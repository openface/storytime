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
    selected_option = prompt.select("Please select: ") do |menu|
      menu.enum '.'
      story_yml['options'].each do |option|
        menu.choice option[1], option[0]
      end
    end

    play_story(selected_option)
  end

end
