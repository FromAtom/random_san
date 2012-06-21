class Button
{
    int x, y;
    int sizeX;
    int sizeY;
    color basecolor, highlightcolor;
    color currentcolor;
    boolean over = false;
    boolean pressed = false;

    void update() 
    {
        if(over()) {
            currentcolor = highlightcolor;
        } 
        else {
            currentcolor = basecolor;
        }
    }

    boolean pressed() 
    {
        if(over) {
            locked = true;
            return true;
        } 
        else {
            locked = false;
            return false;
        }    
    }

    boolean over() 
    { 
        return true; 
    }

    boolean overRect(int x, int y, int width, int height) 
    {
        if (mouseX >= x && mouseX <= x+width && 
            mouseY >= y && mouseY <= y+height) {
            return true;
        } 
        else {
            return false;
        }
    }

}

class RectButton extends Button
{
    RectButton(int ix, int iy, int iwidth, int iheight, color icolor, color ihighlight)
    {
        x = ix;
        y = iy;
        sizeX = iwidth;
        sizeY = iheight;
        basecolor = icolor;
        highlightcolor = ihighlight;
        currentcolor = basecolor;
    }

    boolean over()
    {
        if( overRect(x, y, sizeX, sizeY) ) {
            over = true;
            return true;
        }
        else {
            over = false;
            return false;
        }
    }

    void display()
    {
        stroke(255);
        fill(currentcolor);
        rect(x, y, sizeX, sizeY);
    }
}