require 'Gosu'
require 'Sprite'
require 'Background'

include Gosu

class Game < Gosu::Window
  def initialize
    super(800, 600, false)
    # Background / Menu
    @cursor = Gosu::Image.new(self, 'media/cursor.png')
    @menu = Background.new(self, 'media\\menu.png')
    @title = Sprite.new(self, 'media\\title.png')
    # Character
    @stand_left = Sprite.new(self,'media\\Character/stand_left.png')
    @stand_right = Sprite.new(self,'media\\Character/stand_right.png')
    @walk_left = Sprite.new(self,'media\\Character/walk_left.png')
    @walk_right = Sprite.new(self,'media\\Character/walk_right.png')
    @shoot_left = Sprite.new(self,'media\\Character/shooting_left.png')
    @shoot_right = Sprite.new(self,'media\\Character/shooting_right.png') 
    @stand_right.move_to(350, 445)
    @sprite = @stand_right
    # Game Detection
    @score = 0
    # Game Caption
    self.caption = "Zombie Shooter - Alpha - 0.1.0"
  end

  def update
    # Start Game
    if button_down? KbReturn
      @game_start = true
      @title.hide
    end
   # Updates Sprites (Since they won't show without being called on, you can always update them)
   if @game_start
    @stand_left.move_to(@sprite.x,@sprite.y)
    @stand_right.move_to(@sprite.x,@sprite.y)
    @walk_right.move_to(@sprite.x,@sprite.y)
    @walk_left.move_to(@sprite.x,@sprite.y)
    @shoot_left.move_to(@sprite.x, @sprite.y)
    @shoot_right.move_to(@sprite.x, @sprite.y)
    if @dir == :left then
      @sprite = @stand_left
    elsif @dir == :right then
      @sprite = @stand_right
    end
    # Movement
    if button_down? KbD
      @sprite.adjust_xpos 4
      @sprite = @walk_right
      @dir = :right
    elsif button_down? KbA
      @sprite.adjust_xpos -4
      @sprite = @walk_left
      @dir = :left
    elsif button_down? KbW
      @sprite.adjust_ypos -10 # Idk why we need this?
    elsif button_down? KbSpace and @dir == :left
      @sprite = @shoot_left
    elsif button_down? KbSpace and @dir == :right
      @sprite = @shoot_right
    end
   end
   #END
  end
  
  
  def draw
    @menu.see(0,0,0,1,1.25)
    @title.draw
    @sprite.draw
    @cursor.draw(self.mouse_x, self.mouse_y, 0) # Cursor always on top
  end
  
  
end

Game.new.show
