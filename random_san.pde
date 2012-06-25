import java.awt.datatransfer.DataFlavor;
import java.awt.datatransfer.Transferable;
import java.awt.datatransfer.UnsupportedFlavorException;
import java.awt.dnd.DnDConstants;
import java.awt.dnd.DropTarget;
import java.awt.dnd.DropTargetDragEvent;
import java.awt.dnd.DropTargetDropEvent;
import java.awt.dnd.DropTargetEvent;
import java.awt.dnd.DropTargetListener;
import java.io.File;
import java.io.IOException;

DropTarget dropTarget;

String[] outputWord = new String[2];
String lines[];

boolean inputFlag = false;

color lineColor = #5D6562;
color baseColor = #5D6562;
color highlightColor = #E69917;
final int margin = 30;

boolean locked = false;
RectButton rect1;

void setup(){

    size(300, 300);
    smooth();

    //--Fonr for Mac-----------------------------------
    PFont myFont = loadFont("HiraMaruPro-W4-48.vlw");
    
    //--Fonr for Win-----------------------------------
    //PFont myFont = loadFont("Migu-1C-Regular-48.vlw");
    textFont(myFont, 32);

    rect1 = new RectButton(width/2-35, height-margin, 70, 20,baseColor, highlightColor);

    File f = new File("./default.txt");
    
    if(f.canRead()){
        lines = loadStrings(f);
        randomSelect();
        inputFlag = true;
        lineColor = baseColor;
    }
    else
        println("ng");

    // ==================================================
    // ファイルのドラッグ&ドロップをサポートするコード
    // ==================================================
    dropTarget = new DropTarget(this, new DropTargetListener() {
            public void dragEnter(DropTargetDragEvent dtde) {}
            public void dragOver(DropTargetDragEvent dtde) {
                lineColor = highlightColor;
            }
            public void dropActionChanged(DropTargetDragEvent dtde) {}
            public void dragExit(DropTargetEvent dte) {
                lineColor = baseColor;
            }
            
            public void drop(DropTargetDropEvent dtde) {
                dtde.acceptDrop(DnDConstants.ACTION_COPY_OR_MOVE);
                Transferable trans = dtde.getTransferable();
                List<File> fileNameList = null;
                if(trans.isDataFlavorSupported(DataFlavor.javaFileListFlavor)) {
                    try {
                        fileNameList = (List<File>)
                            trans.getTransferData(DataFlavor.javaFileListFlavor);
                    } catch (UnsupportedFlavorException ex) {
                        /* 例外処理 */
                    } catch (IOException ex) {
                        /* 例外処理 */
                    }
                }
                if(fileNameList == null) return;

                for(File f : fileNameList){
                    lines = loadStrings(f);
                    randomSelect();
                    inputFlag = true;
                    lineColor = baseColor;
                }
            }
        });
    // ==================================================

}

void randomSelect() {
    int index = int(random(lines.length));
    outputWord[0] = lines[index];

    int buf;
    while((buf = int(random(lines.length))) == index){}
    index = buf;
    outputWord[1] = lines[index];
}

void draw() {
    background(#212222);
    
    fill(255);
    textAlign(CENTER);

    if(inputFlag){
        strokeWeight(1);
        update(mouseX, mouseY);
        rect1.display();

        textSize(12);
        fill(255);
        text("わんもあ", width/2, height-15);

        noFill();
        stroke(lineColor);
        strokeWeight(5);
        rect(margin, margin, height-margin*2, height/2+margin);

        fill(255);
        textSize(16);
        text(outputWord[0], width/2, 100);
        text(outputWord[1], width/2, 150);
    }
    else{
        noFill();
        stroke(lineColor);
        strokeWeight(1);
        rect(margin, margin, height-margin*2, height-margin*2);
        
        textSize(16);
        text("ファイルをD＆D！", width/2, height/2+textDescent());
    }
}

void update(int x, int y)
{
    if(locked == false) {
        rect1.update();
    } 
    else {
        locked = false;
    }

    if(mousePressed) {
        if(rect1.pressed()) {
            randomSelect();
        }
    }
}
