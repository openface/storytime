class Game

  GAME_START = 'start'
  GAME_END = 'end'

  def initialize(directory)
    @directory = directory
    @meta = YAML.load_file("#{@directory}/story.yml")
    @stack = []
  end

  def start
    play_story GAME_START
  end

  def play_story(part)
    # Push selection to story stack
    @last_part = @stack.pop
    @stack << part

    story_yml = YAML.load_file("#{@directory}/#{part}.yml")
    puts CLEAR

    #puts @stack.inspect
    puts
    puts story_yml['content']
    puts

    # Speak
    unless ENV['NOTALK']
      talker = Mac::Say.new(voice: :alex, rate: 200)
      talker.say string: story_yml['content']
    end

    exit if part == GAME_END

    # navigate to next part of the story

    prompt = TTY::Prompt.new

    if story_yml['choices']
      # prompt user with choices
      next_part = prompt.select("Please select: ") do |menu|
        menu.enum '.'
        story_yml['choices'].each do |choice|
          menu.choice choice[1], choice[0]
        end
      end
    elsif story_yml['end']
      puts
      puts story_yml['end']
      puts
      exit
    else
      # no choices defined
      next_part = @last_part
      prompt.keypress("Press any key to go back...")
    end

    play_story(next_part)
  end

end
