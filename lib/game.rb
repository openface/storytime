class Game

  def initialize(directory,meta)
    @directory = directory
    @meta = meta
    @stack = []
  end

  def start
    play_story 'init'
  end

  def play_story(filename)
    @stack << filename
    story_yml = YAML.load_file("#{@directory}/#{filename}.yml")
    puts CLEAR
    puts story_yml['content']
    puts

    cli = HighLine.new
    cli.choose do |menu|
      menu.index_suffix = ") "
      menu.character = true
      menu.prompt = "Please choose: "
      story_yml['options'].each do |option|
        menu.choice(option[1]) do
          play_story(option[0])
        end
      end

    end
  end

end
