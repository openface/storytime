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
    puts story_yml['content']
    puts

    prompt = TTY::Prompt.new
    selected_choice = prompt.select("Please select: ") do |menu|
      menu.enum '.'
      story_yml['choices'].each do |choice|
        menu.choice choice[1], choice[0]
      end
    end

    play_story(selected_choice)
  end

end
