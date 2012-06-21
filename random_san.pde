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
boolean inputFlag = false;

void setup(){

    size(300, 300);
    smooth();
    PFont myFont = loadFont("HiraMaruPro-W4-48.vlw");
    textFont(myFont, 32);

    // ==================================================
    // ファイルのドラッグ&ドロップをサポートするコード
    // ==================================================
    dropTarget = new DropTarget(this, new DropTargetListener() {
            public void dragEnter(DropTargetDragEvent dtde) {}
            public void dragOver(DropTargetDragEvent dtde) {}
            public void dropActionChanged(DropTargetDragEvent dtde) {}
            public void dragExit(DropTargetEvent dte) {}
            
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
                    String lines[] = loadStrings(f);

                    int index = int(random(lines.length));
                    outputWord[0] = lines[index];

                    index = int(random(lines.length));
                    outputWord[1] = lines[index];


                    inputFlag = true;

                    /*
                    for (int i=0; i < lines.length; i++) {
                        println(lines[i]);
                    }
                    */
                }
            }
        });
    // ==================================================

}

void draw() {
    background(255);
    fill(0);
    textAlign(CENTER);

    if(inputFlag){
        text(outputWord[0], width/2, 50);
        text(outputWord[1], width/2, 100);
    }
    else{
        textSize(16);
        text("ファイルをD＆D！", width/2, height/2);
    }
    /* 省略 */
}