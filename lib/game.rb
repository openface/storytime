class Game

  def initialize(directory)
    @directory = directory
    @meta = YAML.load_file("#{@directory}/story.yml")
    @stack = []
  end

  def start
    play_story 'init'
  end

  def play_story(filename)
    # Push selection to story stack
    @stack << filename

    story_yml = YAML.load_file("#{@directory}/#{filename}.yml")
    puts CLEAR
    #puts @stack.inspect
    puts
    puts story_yml['content']
    puts

    if filename == 'end'
      # end story
      exit
    else
      # navigate to next part of the story

      prompt = TTY::Prompt.new
      
      if story_yml['choices']
        # prompt user with choices
        next_story = prompt.select("Please select: ") do |menu|
          menu.enum '.'
          story_yml['choices'].each do |choice|
            menu.choice choice[1], choice[0]
          end
        end
      else
        # no choices defined
        next_story = @stack.pop(2).first
        prompt.keypress("Press any key to go back")
      end

      play_story(next_story)
    end
  end

end
