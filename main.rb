require 'Gosu'
require 'Sprite'
require 'Background'

include Gosu

class Game < Gosu::Window
  def initialize
    super(800, 600, false)
    @cursor = Gosu::Image.new(self, 'media/cursor.png')
    @menu = Background.new(self, 'media\\menu.png')
    @title = Sprite.new(self, 'media\\title.png')
    #character
    @stand_left = Sprite.new(self,'media\\Character\\stand_left.png')
    @stand_right = Sprite.new(self,'media\\Character\\stand_right.png')
    @walk_left = Sprite.new(self,'media\\Character\\walk_left.png')
    @walk_right = Sprite.new(self,'media\\Character\\walk_right.png')
    @shoot_left = Sprite.new(self,'media\\Character\\shooting_left.png')
    @shoot_right = Sprite.new(self,'media\\Character\\shooting_right.png') 
    @stand_right.move_to(350, 445)
    @sprite = @stand_right
    #$game_start = false
    $score = 0
    $window = self
    self.caption = "Zombie Shooter - Alpha - 0.0.1"
  end

  def update
    if button_down?(KbReturn)
      $game_start = true
      @title.hide
    end
     if $game_start == true
      if @dir == :left then
        @stand_left.move_to(@sprite.x,@sprite.y)
        @sprite = @stand_left
      elsif @dir == :right then
        @stand_right.move_to(@sprite.x,@sprite.y)
        @sprite = @stand_right
      end
      if button_down?(KbD)
        @sprite.adjust_xpos 4 
        @walk_right.move_to(@sprite.x,@sprite.y)
        @sprite = @walk_right
        @dir = :right
      elsif button_down?(KbA)
        @sprite.adjust_xpos -4
        @walk_left.move_to(@sprite.x,@sprite.y)
        @sprite = @walk_left
        @dir = :left
      elsif button_down?(KbW)
        @sprite.adjust_ypos(-10)
      elsif button_down?(KbSpace)and @dir == :left
          @shoot_left.move_to(@sprite.x, @sprite.y) #necessary because else would move back since edge is different
        @sprite = @shoot_left
      elsif button_down?(KbSpace)and @dir == :right
        @shoot_right.move_to(@sprite.x, @sprite.y)
        @sprite = @shoot_right
      end
     end
  end
  
  
  def draw
    @menu.see(0,0,0,1,1.25)
    @title.draw
    @cursor.draw(self.mouse_x, self.mouse_y, 0)
    @sprite.draw
  end
  
  
end

Game.new.show