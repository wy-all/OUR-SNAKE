int game_state;
float _speed;
Level Mylevel;
Game_Text gtext;
Card card[];

void setup()
{
  _speed=1;
  game_state=0;
  gtext=new Game_Text();
  card=new Card[5];
  card[0]=new Card(100, 200, 50, 50, "1");
  card[1]=new Card(200, 200, 50, 50, "2");
  card[2]=new Card(300, 200, 50, 50, "3");
  card[3]=new Card(200, 300, 50, 50, "4");
  card[4]=new Card(300, 300, 50, 50, "5");

  size(640, 480);
}
void draw()
{
  if (game_state==0)
  {
    background(0, 0, 0);
    gtext.Show1();
    for (int i=0; i<card.length; i++)
    {
      card[i].Func();
      if (card[i].isPress)
      {
        card[i].isPress=false;
        game_state=1;
        switch(i+1)
        {
        case 1:
          {
            Mylevel=new Level(null, 320, 300, 1);
            Mylevel.SetBG(150, 255, 150);
          }
          break;
        case 2:
          {
            Wall wall[]=new Wall[4];
            wall[0]=new Wall(50, 90, 100, 20);
            wall[1]=new Wall(90, 50, 20, 100);
            wall[2]=new Wall(width-150, height-190, 20, 100);
            wall[3]=new Wall(width-190, height-150, 100, 20);
            Mylevel=new Level(wall, 320, 300, 1);
          }
          break;
        case 3:
          {
            Wall wall[]=new Wall[3];
            wall[0]=new Wall(100, 100, 20, 250);
            wall[1]=new Wall(100, 225, 400, 20);
            wall[2]=new Wall(500, 100, 20, 250);
            Mylevel=new Level(wall, 100, 400, 4);
          }
          break;
        case 4:
          {
            Wall wall[]=new Wall[8];
            wall[0]=new Wall(0, 0, 640, 20);
            wall[1]=new Wall(0, 0, 20, 480);
            wall[2]=new Wall(620, 0, 20, 480);
            wall[3]=new Wall(0, 460, 640, 20);
            wall[4]=new Wall(100, 100, 20, 250);
            wall[5]=new Wall(100, 225, 150, 20);
            wall[6]=new Wall(360, 225, 150, 20);
            wall[7]=new Wall(500, 100, 20, 250);
            Mylevel=new Level(wall, 100, 400, 4);
          }
          break;
        case 5:
          {
            Wall wall[]=new Wall[10];
            wall[0]=new Wall(0, 0, 640, 20);
            wall[1]=new Wall(0, 0, 20, 480);
            wall[2]=new Wall(620, 0, 20, 480);
            wall[3]=new Wall(0, 460, 640, 20);
            wall[4]=new Wall(160, 180, 20, 120);
            wall[5]=new Wall(460, 180, 20, 120);
            wall[6]=new Wall(140, 120, 120, 20);
            wall[7]=new Wall(380, 120, 120, 20);
            wall[8]=new Wall(140, 340, 120, 20);
            wall[9]=new Wall(380, 340, 120, 20);
            Mylevel=new Level(wall, 320, 300, 1);
          }
          break;
        default:
          break;
        }
      }
    }
  }
  if (game_state==1)
  {
    Mylevel.Func();
    gtext.Show2(Mylevel);
  } else if (game_state==2)
  {
    background(0, 0, 0);
    gtext.Show3(Mylevel);
  } else if (game_state==3)
  {
    Mylevel.time.Stop();
  }
}

class Ball
{
  int direction;
  float x;
  float y;
  float r;
  float turn_x;
  float turn_y;
  int turn_direction;
  float R, G, B;
  Ball(float x, float y, float r, int direction)
  {
    this.x=x;
    this.y=y;
    this.r=r;
    this.direction=direction;
    turn_x=0;
    turn_y=0;
    turn_direction=0;
    R=random(0, 1)*255;
    G=random(0, 1)*255;
    B=random(0, 1)*255;
  }
  float GetAfterX(float r1)
  {
    if (direction==1)
    {
      return x;
    } else if (direction==2)
    {
      return x;
    } else if (direction==3)
    {
      return x+r+r1;
    } else
    {
      return x-r-r1;
    }
  }
  float GetAfterY(float r1)
  {
    if (direction==1)
    {
      return y+r+r1;
    } else if (direction==2)
    {
      return y-r-r1;
    } else if (direction==3)
    {
      return y;
    } else
    {
      return y;
    }
  }
  void ReadyTurn()
  {
    if (x==turn_x&&y==turn_y)
    {
      direction=turn_direction;
      turn_x=-1;
      turn_y=-1;
    }
  }
  boolean GetTurn()
  {
    if (x==turn_x&&y==turn_y)
    {
      return true;
    }
    return false;
  }
  void Func()
  {
    ReadyTurn();
    if (direction==1)
    {
      if (y>0)
        y-=1;
      else
        y=height;
    } else if (direction==2)
    {
      if (y<height)
        y+=1;
      else
        y=0;
    } else if (direction==3)
    {
      if (x>0)
        x-=1;
      else
        x=width;
    } else if (direction==4)
    {
      if (x<width)
        x+=1;
      else
        x=0;
    }
    fill(R, G, B);
    ellipse(x, y, 2*r, 2*r);
  }
}

class Snaker
{
  int _length;
  Ball allBall[];
  int Max_length;
  Level level;
  Wall itWall[];
  Snaker(float x, float y, int direction, Wall itWall[])
  {
    Max_length=100;
    _length=1;
    allBall=new Ball[Max_length];
    allBall[_length-1]=new Ball(x, y, 10, direction);
    this.itWall=itWall;
  }
  void Func()
  {
    for (int i=1; i<_length; i++)//turn
    {
      if (allBall[i-1].GetTurn())
      {
        allBall[i].turn_x=allBall[i-1].turn_x;
        allBall[i].turn_y=allBall[i-1].turn_y;
        allBall[i].turn_direction=allBall[i-1].turn_direction;
      }
      if (dist(allBall[0].x, allBall[0].y, allBall[i].x, allBall[i].y)<allBall[0].r)
      {
        game_state=2;
      }
    }
    if (itWall!=null)
    {
      for (int i=0; i<itWall.length; i++)
      {
        float x=allBall[0].x;
        float y=allBall[0].y;
        Wall wall=itWall[i];
        if (x>wall.x&&x<wall.x+wall._width)
        {
          if (y>wall.y&&y<wall.y+wall._height)
          {
            game_state=2;
            break;
          }
        }
      }
    }

    for (int i=0; i<_length; i++)//work
    {
      allBall[i].Func();
    }
  }
  void Grow()
  {
    if (_length<Max_length)
    {
      allBall[_length]=new Ball(allBall[_length-1].GetAfterX(allBall[0].r), allBall[_length-1].GetAfterY(allBall[0].r), allBall[0].r, allBall[_length-1].direction);
      _length++;
    }
  }
  void Eat(Bug bug, Level level)
  {
    if (dist(bug.x, bug.y, allBall[0].x, allBall[0].y)<bug.r+allBall[0].r)
    {
      bug.isDie=true;
      this.Grow();
      level.score+=int(50-bug.r);
    }
  }
}

class Bug
{
  float x;
  float y;
  float r;
  boolean isDie;
  Level level;
  Bug(Level level)
  {
    this.level=level;
    r=random(0.1, 1)*50;
    x=random(r, width-r);
    y=random(r, height-r);
  }
  void Func()
  {
    if (isDie)
    {
      isDie=false;
      
      r=random(0.1, 1)*50;
      x=random(r, width-r);
      y=random(r, height-r);
      /*Ball balls[]=level.snaker.allBall;
       for (int i=0; i<balls.length; i++)
       {
       if (dist(x, y, balls[i].x, balls[i].y)<r+balls[i].r)
       {
       isDie=true;
       break;
       }
       }*/
      Wall walls[]=level.AllWall;
      if (walls!=null)
      {
        for (int i=0; i<walls.length; i++)
        {
          if (x+r>walls[i].x&&x-r<walls[i].x+walls[i]._width)
          {
            if (y+r>walls[i].y&&y-r<walls[i].y+walls[i]._height)
            {
              isDie=true;
              break;
            }
          }
        }
      }
    } else
    {
      stroke(0,0,0);
      fill(255, 255, 255);
      ellipse(x, y, 2*r, 2*r);
    }
  }
}

class Wall
{
  float x;
  float y;
  float _width;
  float _height;
  Wall(float x, float y, float _width, float _height)
  {
    this.x=x;
    this.y=y;
    this._width=_width;
    this._height=_height;
  }
  void Func()
  {
    noStroke();
    fill(125, 125, 125);
    rect(x, y, _width, _height);
  }
}

class Game_Text
{
  void Show1()
  {
    fill(255, 255, 255);
    textSize(40);
    textAlign(LEFT);
    text("welcome to snaker!", 20, 50);
    text("speed:"+_speed, 20, 100);
  }
  void Show2(Level level)
  {
    fill(255, 255, 255);
    textSize(20);
    textAlign(LEFT);
    text("score:"+level.score, 20, 20);
    text("length:"+level.snaker._length, 20, 50);
    text("time:"+level.time.getMinute()+":"+level.time.getSecond(), 20, 80);
  }
  void Show3(Level level)
  {
    fill(255, 255, 255);
    textSize(40);
    textAlign(LEFT);
    text("defeat", 20, 50);
    text("score:"+level.score, 20, 100);
    text("length:"+level.snaker._length, 20, 150);
    text("time:"+level.time.getMinute()+":"+level.time.getSecond(), 20, 180);
    text("get score speed:"+(level.score/level.time.game_time)+"/s", 20, 250);
    text("click to restart game", 20, 300);
    text("speed:"+_speed, 20, 350);
  }
}

class Time
{
  int second;
  int minute;
  int hour;
  int game_time;
  int save_time;
  int total_time;
  Time()
  {
    second=second();
    minute=minute();
    hour=hour();
  }
  void Stop()
  {
    total_time=(hour()-hour)*3600+(minute()-minute)*60+second()-second;
    save_time=total_time-game_time;
    println(save_time);
  }
  void Func()
  {
    total_time=(hour()-hour)*3600+(minute()-minute)*60+second()-second;
    game_time=total_time-save_time;
  }
  int getSecond()
  {
    return game_time%60;
  }
  int getMinute()
  {
    return game_time/
      60;
  }
}

class Level
{
  int R, G, B;
  int direction;
  float speed;
  float score;
  Snaker snaker;
  Bug bug;
  Wall AllWall[];
  Time time;
  Level(Wall AllWall[], float x, float y, int direction)
  {
    R=G=B=0;
    speed=_speed;
    score=0;
    this.direction=direction;
    snaker=new Snaker(x, y, direction, AllWall);
    snaker.Grow();
    bug=new Bug(this);
    this.AllWall=AllWall;
    this.time=new Time();
  }
  void Func()
  {
    background(R, G, B);
    for (int i=0; i<speed; i++)
    {
      snaker.Func();
      bug.Func();
      snaker.Eat(bug, this);
    }
    if (AllWall!=null)
    {
      for (int i=0; i<AllWall.length; i++)
      {
        AllWall[i].Func();
      }
    }
    time.Func();
    keyPressed();
  }
  void SetBG(int R, int G, int B)
  {
    this.R=R;
    this.G=G;
    this.B=B;
  }
  void keyPressed()
  {
    if (key == CODED) 
    {
      if (game_state==1)
      {
        if (keyCode==UP)
        {
          if (direction!=2)
            direction=1;
        } else if (keyCode == DOWN)
        {
          if (direction!=1)
            direction=2;
        } else if (keyCode==LEFT)
        {
          if (direction!=4)
            direction=3;
        } else if (keyCode==RIGHT)
        {
          if (direction!=3)
            direction=4;
        }

        if (snaker.allBall[0].direction==snaker.allBall[1].direction)
        {
          snaker.allBall[0].direction=direction;
          snaker.allBall[0].turn_x=snaker.allBall[0].x;
          snaker.allBall[0].turn_y=snaker.allBall[0].y;
          snaker.allBall[0].turn_direction=snaker.allBall[0].direction;
        }
      }
    }
    if (keyPressed)
    {
      if (key==ENTER)
      {
        if (game_state==1)
        {
          game_state=0;
        }
      }
      if (key==TAB)
      {
        if (game_state==1)
        {
          game_state=3;
        } else if (game_state==3)
        {
          game_state=1;
        }
      }
    }
  }
}

class Card
{
  float x;
  float y;
  float _width;
  float _height;
  float fontSize;
  String str;
  boolean isPress;
  int R, G, B;
  int R1, G1, B1;
  int tR, tG, tB;
  Card(float x, float y, float _width, float _height, String str)
  {
    this.x=x;
    this.y=y;
    this._width=_width;
    this._height=_height;
    this.str=str;
    R=G=B=255;
    R1=255;
    G1=B1=0;
    fontSize=30;
  }
  void Func()
  {
    mousePressed();
    if (mouseX>x&&mouseX<x+_width)
    {
      if (mouseY>y&&mouseY<y+_height)
      {
        fill(R1, G1, B1);
      } else
      {
        fill(R, G, B);
      }
    } else
    {
      fill(R, G, B);
    }
    rect(x, y, _width, _height);
    fill(0, 0, 0);
    textSize(fontSize);
    textAlign(CENTER, CENTER);
    text(str, x+_width/2, y+_height/2);
  }
  void SetRGB(int R, int G, int B)
  {
    this.R=R;
    this.G=G;
    this.B=B;
  }
  void SetRGB1(int R1, int G1, int B1)
  {
    this.R1=R1;
    this.G1=G1;
    this.B1=B1;
  }
  void SetTextRGB(int tR, int tG, int tB)
  {
    this.tR=tR;
    this.tG=tG;
    this.tB=tB;
  }
  void SetFontSize(float size)
  {
    this.fontSize=size;
  }
  void mousePressed()
  {
    if (mousePressed)
    {
      if (mouseX>x&&mouseX<x+_width)
      {
        if (mouseY>y&&mouseY<y+_height)
        {
          isPress=true;
        }
      }
    }
  }
}

void mousePressed()
{
  if (game_state==2)
  {
    game_state=0;
  } else if (game_state==1)
  {
    game_state=3;
  } else if (game_state==3)
  {
    game_state=1;
  }
}
void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  if (game_state==0||game_state==2)
  {
    if (e>0)
    {
      if (_speed>1)
        _speed--;
    } else if (e<0) {
      _speed++;
    }
  }
}
void keyPressed()
{
  if (keyPressed)
  {
    if (key==ENTER)
    {
      if (game_state==1||game_state==3)
      {
        game_state=0;
      }
    }
  }
}