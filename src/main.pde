import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;

// GLOBAL VARIABLES
Menu mainMenu;
ArrayList<MenuItem> expandedItems;
PFont font;

Menu firstMenu;
Menu secondMenu;
Menu thirdMenu;
Menu thirdMenu2;
Menu fourthMenu;
Menu fifthMenu;

UserSat usr;

Prompt p;

long trialStartTime = 0;
int errorsForThisTrial = 0;
boolean rightTargetClicked = false;

int NUMBER_OF_TRIALS = 20;

ArrayList<String> trialItems = new ArrayList<String>();

public enum Stage {
    INSTRUCTIONS, BEFORE_COMBO, FIRST_COMBO, FIRST_SAT, SECOND_COMBO, SECOND_SAT, THIRD_COMBO, THIRD_SAT,
    FORTH_COMBO, FORTH_SAT, FIFTH_COMBO, FIFTH_SAT, FINISHED;
}

String[] itemNames = {
    "New File", "Open File", "Save", "Save As", "Export", "Undo", "Redo", "Cut", "Copy", "Paste", "Crop", "Resize", "Rotate",
    "Brightness Adjustment", "Contrast Adjustment", "Saturation Adjustment", "Hue Adjustment", "Apply Filter", "Add Text",
    "Draw", "Erase", "Zoom In", "Zoom Out", "Import", "Print", "Convert to Format",
    "Add Layer", "Remove Layer", "Merge Layers", "Flatten Image"
};

String[] itemNames2 = {
    "Clone Stamp", "New File",  "Cut", "Copy", "Paste", "Crop", "Resize", "Rotate",
    "Brightness Adjustment", "Contrast Adjustment", "Select", "Deselect", "Saturation Adjustment", "Hue Adjustment", "Apply Filter", "Add Text",
    "Draw", "Erase", "Zoom In", "Zoom Out", "Import", "Print", "Convert to Format",
    "Add Layer", "Remove Layer", "Merge Layers", "Open File", "Save", "Save As", "Export", "Undo", "Redo", "Flatten Image", "Invert Selection", "Adjust Levels", "Curves Adjustment", "Color Balance",
    "Sharpen", "Blur", "Healing Brush", "Magic Wand", "Lasso Tool", "Pen Tool",
    "Gradient Tool", "Text Tool", "Bucket Fill", "Brush Tool", "History Brush", "Dodge Tool", "Burn Tool",
    "Sponge Tool", "Path Selection", "Direct Selection", "Rectangle Tool", "Ellipse Tool", "Free Transform",
    "Perspective Transform", "Warp Transform", "Align Layers", "Distribute Layers"
};

private Stage currentStage;

String instructionText = "In this study you will complete several tasks.\n" +
"Work as quickly and accurately as possible.\n" +
"You are shown five different Menus, and for each menu,\n" +
"a prompt on the top-right corner. Select the corresponding item.\n" +
"Press Enter to continue.";

String beforeComboText = "Now you will see the next menu.\n" +
"Click on the correct item shown on the top-left corner.\n" +
"The menu items that can be expanded are indicated by an arrow\n" +
"in front of them.\n" +
"You can expand or collapse them by clicking on them.\n" +
"After the Trials for this phase is ended, rate your interaction.\n" +
"Click anywhere to begin.";

String finishedText = "All trials complete.";

void setup() {
    size(1200, 800);
    font = createFont("Times New Roman", 30, true);
    expandedItems = new ArrayList<MenuItem>();
    initMenus();
    refreshTrialItems();
    textFont(font);
    
    p = new Prompt(1000, 50);
    p.setPrompt(trialItems.get(0));
    
    usr = new UserSat(); // Initialize UserSat here
    
    currentStage = Stage.INSTRUCTIONS;
}


void draw() {
    background(240);
    switch(currentStage) {
        	case INSTRUCTIONS:
            		fill(5);
            		textSize(32);
            		textAlign(CENTER);
            		textFont(font);
            		text(instructionText, width / 2, 150);
                break;
        	case BEFORE_COMBO:
                    fill(0);
            		textSize(32);
            		textAlign(CENTER);
            		text(beforeComboText, width / 2, 150);
                break;
            case FIRST_SAT:
            case SECOND_SAT:
            case THIRD_SAT:
            case FORTH_SAT:
            case FIFTH_SAT:
                usr.display();
                break;
        	case FIRST_COMBO:
            		firstMenu.display();
                    firstMenu.checkHover();
            		p.display();
            		break;
        	case SECOND_COMBO:
            		secondMenu.display();
                    secondMenu.checkHover();
            		p.display();
            		break;
        	case THIRD_COMBO:
            		thirdMenu.display();
                    thirdMenu.checkHover();
                    thirdMenu2.display();
                    thirdMenu2.display();
            		p.display();
            		break;
        	case FORTH_COMBO:
            		fourthMenu.display();
                    fourthMenu.checkHover();
            		p.display();
            		break;
        	case FIFTH_COMBO:
            		fifthMenu.display();
                    fifthMenu.checkHover();
            		p.display();
            		break;
        	case FINISHED:
            background(150,255,150);
            fill(0);
            		textSize(32);
            		textAlign(CENTER);
            		text(finishedText, width / 2, 150);
            break;
    }
}

// CONTROLLER functions -----------------------------------------------

void mousePressed() {
    if (currentStage == Stage.FIRST_SAT || currentStage == Stage.SECOND_SAT || currentStage == Stage.THIRD_SAT || currentStage == Stage.FORTH_SAT || currentStage == Stage.FIFTH_SAT) {
    usr.mousePressed();
  }
    if (currentStage == Stage.BEFORE_COMBO) {
        print("FIRST STAGE...\n");
        trialStartTime = System.currentTimeMillis();
        currentStage = Stage.FIRST_COMBO;
    } else if (currentStage == Stage.FIRST_COMBO) {
        firstMenu.mousePressed();
    } else if (currentStage == Stage.SECOND_COMBO) {
        secondMenu.mousePressed();
    } else if (currentStage == Stage.THIRD_COMBO) {
        thirdMenu.mousePressed();
        thirdMenu2.mousePressed();
    } else if (currentStage == Stage.FORTH_COMBO) {
        fourthMenu.mousePressed();
    } else if (currentStage == Stage.FIFTH_COMBO) {
        fifthMenu.mousePressed();
    }
}

void keyPressed() {
    if (keyCode == ENTER && currentStage == Stage.INSTRUCTIONS) {
        currentStage = Stage.BEFORE_COMBO;
    } else if (key == '1') {
        currentStage = Stage.FIRST_COMBO;
        if (firstMenu == null) setupFirstMenu();
    } else if (key == '2') {
        currentStage = Stage.SECOND_COMBO;
        if (secondMenu == null) setupSecondMenu();
    } else if (key == '3') {
        currentStage = Stage.THIRD_COMBO;
        if (thirdMenu == null) setupThirdMenu();
    } else if (key == '4') {
        currentStage = Stage.FORTH_COMBO;
        if (fourthMenu == null) setupFourthMenu();
    } else if (key == '5') {
        currentStage = Stage.FIFTH_COMBO;
        if (fifthMenu == null) setupFifthMenu();
    }
}

// MODEL CLASSES --------------------------------------------------

class UserSat {
  int x = width / 2 - 350;
  int y = 150;
  int w = 700;
  int h = 100;
  String prompt = "How easy was is to choose an item (0-10)";
  
  void display() {
    fill(0);
    textSize(26);
    textAlign(CENTER, CENTER);
    text(prompt, x + w / 2, y - 40);

    int rectWidth = w / 11;
    for (int i = 0; i <= 10; i++) {
      int rectColor = lerpColor(color(255, 0, 0), color(0, 255, 0), i / 10.0);
      fill(rectColor);
      
      if (mouseX >= x + i * rectWidth && mouseX < x + (i + 1) * rectWidth && mouseY >= y && mouseY <= y + h) {
        fill(255, 255, 0);
      }

      rect(x + i * rectWidth, y, rectWidth, h);

      fill(0);
      textSize(16);
      text(i, x + i * rectWidth + rectWidth / 2, y + h / 2);
      textAlign(CENTER);
    }
  }

  void mousePressed() {
    int rectWidth = w / 11;
    if (mouseY >= y && mouseY <= y + h) {
      for (int i = 0; i <= 10; i++) {
        if (mouseX >= x + i * rectWidth && mouseX < x + (i + 1) * rectWidth) {
          println(i);
          trialStartTime = System.currentTimeMillis();

            if (currentStage == Stage.FIRST_SAT) {
                currentStage = Stage.SECOND_COMBO;
                print("SECOND STAGE...\n");
            }
            else if (currentStage == Stage.SECOND_SAT) {
                 currentStage = Stage.THIRD_COMBO;
                 print("THIRD STAGE...\n");
            }
            else if (currentStage == Stage.THIRD_SAT) { 
                currentStage = Stage.FORTH_COMBO;
                print("FORTH STAGE...\n");
            }
            else if (currentStage == Stage.FORTH_SAT) {
                currentStage = Stage.FIFTH_COMBO;
                print("FIFTH STAGE...\n");
            }
            else if (currentStage == Stage.FIFTH_SAT) {
                currentStage = Stage.FINISHED;
            }
          break;
        }
      }
    }
  }
}




class Prompt {
    String name = "";
    int x, y;
    
    Prompt(int x, int y) {
        this.x = x;
        this.y = y;
    }
    
    void setPrompt(String name) {
        this.name = name;
    }
    
    void display() {
        textSize(30);
        fill(0);
        text("Find and Select", x, y);
        fill(255,0,0);
        text('"' + this.name + '"', x, y + 40);

        fill(50);
        if (currentStage == Stage.FIRST_COMBO) {
            text("First Stage", x, y + 660);
        }
        if (currentStage == Stage.SECOND_COMBO) {
            text("Second Stage", x, y + 660);
        }
        if (currentStage == Stage.THIRD_COMBO) {
            text("Third Stage", x, y + 660);
        }
        if (currentStage == Stage.FORTH_COMBO) {
            text("Forth Stage", x, y + 660);
        }
        if (currentStage == Stage.FIFTH_COMBO) {
            text("Fifth Stage", x, y + 660);
        }
        fill(100);
        text(trialItems.size() + " Items Remaining", x, y + 700);

    }
}

class MenuItem {
    int x;
    int y;
    int width = 220;
    int height = 25;
    String label;
    Menu childMenu;
    boolean isShown;
    
    MenuItem(String label, int x, int y) {
        this.x = x;
        this.y = y;
        this.label = label;
        isShown = false;
    }
    
    void display() {
        // if this is a parent
        if (childMenu != null) {
            // if hovered over
            if (this.containsMouse()) {
                fill(200);
                textSize(20);
                rect(x, y, 220, 25);
                fill(0);
                text(label, x + 110, y + 20);
                text(">", x + 210, y + 20);
            }
            // if it is not hovered over
            else {
                fill(255);
                textSize(20);
                rect(x, y, 220, 25);
                fill(0);
                text(label, x + 110, y + 20);
                text(">", x + 210, y + 20);
            }
        }
        
        // if this is leaf
        else {
            // if hovered over
            if (this.containsMouse()) {
                fill(200);
                textSize(20);
                rect(x, y, 220, 25);
                fill(0);
                text(label, x + 110, y + 20);
            }
            // if it is not hovered over
            else {
                fill(255);
                textSize(20);
                rect(x, y, 220, 25);
                fill(0);
                text(label, x + 110, y + 20);
            }
        }
    }

    boolean isHovered() {
        return mouseX > x && mouseX < x + width && mouseY > y && mouseY < y + height;
    }

    void mousePressed() {
        if (this.isShown) {
            if (this.childMenu == null) {
                if (p.name.equals(this.label) && this.containsMouse()) {
                    endTrial(this.label);
                }
            }
        }
    }
    
    boolean containsMouse() {
        return mouseX >= x && mouseX <= x + width && mouseY >= y && mouseY <= y + height;
    }
}


class Menu {
    ArrayList<MenuItem> items;
    int x, y;
    int heightOfEachItem = 25;
    // The y of the last item
    MenuItem expandedItem;
    
    Menu(int x, int y) {
        this.x = x;
        this.y = y;
        this.items = new ArrayList<MenuItem>();
    }
    
    void addItem(String label) {
        MenuItem thisItem = new MenuItem(label, x, this.y + items.size() * heightOfEachItem);
        items.add(thisItem);
    }

    void addMenutoItem(Menu menu, String label) {
        for (MenuItem item : items) {
            if (item.label.equals(label)) {
                menu.setXY(this.x + item.width, item.y);
                item.childMenu = menu;
                break;
            }
        }
    }
    
    void display() {
        // display this menu
        for (MenuItem item : items) {
            item.display();

            // display the expanded menu
            if (expandedItem != null && expandedItem.label.equals(item.label)) {
                item.childMenu.display();
            }
        }
    }

    void checkHover() {
        for (MenuItem item : items) {
            if (item.childMenu != null) {
                if (item.isHovered() && expandedItem != item) {
                if (expandedItem != null) {
                    // Hide the previously expanded item's child menu
                    for (MenuItem i : expandedItem.childMenu.items) {
                        i.isShown = false;
                    }
                }
                expandedItem = item;
                for (MenuItem i : item.childMenu.items) {
                    i.isShown = true;
                }
            }
                item.childMenu.checkHover();
            }
            
        }
    }
    
    void mousePressed() {
        for (MenuItem item : items) {
            if (item.isShown) {
                if (item.childMenu != null) {
                if (item.containsMouse()) {
                    if (this.expandedItem != null && item.label.equals(this.expandedItem.label)) {
                        this.expandedItem = null;
                        for (MenuItem i : item.childMenu.items) {
                            i.isShown = false;
                        }
                    }
                    else {
                        this.expandedItem = item;
                        for (MenuItem i : item.childMenu.items) {
                            i.isShown = true;
                        }
                    }
                }
                item.childMenu.mousePressed();
                }

                item.mousePressed();
            }
            
        }
    }

    void setXY(int x, int y) {
        this.x = x;
        this.y = y;
        for (MenuItem item : items) {
            item.x = x;
            item.y = y + items.indexOf(item) * heightOfEachItem;
        }
    }
}

// UTILITY Functions --------------------------------------------------

void refreshTrialItems() {
    trialItems.clear();
    
    ArrayList<String> t = new ArrayList<String>(Arrays.asList(itemNames));
    while(trialItems.size() < NUMBER_OF_TRIALS) {
        
        Collections.shuffle(t);
        for (String item : t) {
            if (trialItems.size() < NUMBER_OF_TRIALS) {
                trialItems.add(item);
            } else {
                break;
            }
        }
    }
}

void refreshTrialItems2() {
    trialItems.clear();
    
    ArrayList<String> t = new ArrayList<String>(Arrays.asList(itemNames2));
    while(trialItems.size() < NUMBER_OF_TRIALS) {
        
        Collections.shuffle(t);
        for (String item : t) {
            if (trialItems.size() < NUMBER_OF_TRIALS) {
                trialItems.add(item);
            } else {
                break;
            }
        }
    }
}

void endTrial(String selectedItem) {
    long trialEndTime = System.currentTimeMillis();
    long elapsed = trialEndTime - trialStartTime;
    
    println(selectedItem + ", " + elapsed);
    
    trialItems.remove(0);
    if (!trialItems.isEmpty()) {
        p.setPrompt(trialItems.get(0));

    // If the trials for the current stage is finished
    } else {
        if (currentStage == Stage.FIRST_COMBO) {
            refreshTrialItems();
            p.setPrompt(trialItems.get(0));
            currentStage = Stage.FIRST_SAT;
            if (secondMenu == null) setupSecondMenu();
        } else if (currentStage == Stage.SECOND_COMBO) {
            refreshTrialItems2();
            p.setPrompt(trialItems.get(0));
            currentStage = Stage.SECOND_SAT;
            if (thirdMenu == null) setupThirdMenu();
        } else if (currentStage == Stage.THIRD_COMBO) {
            refreshTrialItems2();
            p.setPrompt(trialItems.get(0));
            currentStage = Stage.THIRD_SAT;
            if (fourthMenu == null) setupFourthMenu();
        } else if (currentStage == Stage.FORTH_COMBO) {
            refreshTrialItems2();
            p.setPrompt(trialItems.get(0));
            currentStage = Stage.FORTH_SAT;
            if (fifthMenu == null) setupFifthMenu();
        } else if (currentStage == Stage.FIFTH_COMBO) {
            print("FINISHED\n");
            currentStage = Stage.FIFTH_SAT;
        }
    }
    trialStartTime = System.currentTimeMillis();
    errorsForThisTrial = 0;
}

void initMenus() {
    setupFirstMenu();
    setupSecondMenu();
    setupThirdMenu();
    setupFourthMenu();
    setupFifthMenu();
}

void setupFirstMenu() {
    //First Menu
    firstMenu = new Menu(20, 20);
    for (String s : itemNames) {
        firstMenu.addItem(s);
    }
    for (MenuItem i : firstMenu.items) {
        i.isShown = true;
    }
}

void setupSecondMenu() {
    secondMenu = new Menu(20, 20);

    // File Operations
    secondMenu.addItem("File");
    Menu fileOperationsMenu = new Menu(220, 20);
    secondMenu.addMenutoItem(fileOperationsMenu, "File");
    fileOperationsMenu.addItem("New File");
    fileOperationsMenu.addItem("Open File");
    fileOperationsMenu.addItem("Save");
    fileOperationsMenu.addItem("Save As");
    fileOperationsMenu.addItem("Export");
    fileOperationsMenu.addItem("Import");
    fileOperationsMenu.addItem("Print");
    fileOperationsMenu.addItem("Convert to Format");

    // Edit Operations
    secondMenu.addItem("Edit");
    Menu editOperationsMenu = new Menu(220, 20);
    secondMenu.addMenutoItem(editOperationsMenu, "Edit");
    editOperationsMenu.addItem("Undo");
    editOperationsMenu.addItem("Redo");
    editOperationsMenu.addItem("Cut");
    editOperationsMenu.addItem("Copy");
    editOperationsMenu.addItem("Paste");

    // Image Adjustments
    secondMenu.addItem("Image");
    Menu imageAdjustmentsMenu = new Menu(220, 20);
    secondMenu.addMenutoItem(imageAdjustmentsMenu, "Image");
    imageAdjustmentsMenu.addItem("Crop");
    imageAdjustmentsMenu.addItem("Resize");
    imageAdjustmentsMenu.addItem("Rotate");
    imageAdjustmentsMenu.addItem("Brightness Adjustment");
    imageAdjustmentsMenu.addItem("Contrast Adjustment");
    imageAdjustmentsMenu.addItem("Saturation Adjustment");
    imageAdjustmentsMenu.addItem("Hue Adjustment");

    // Tools
    secondMenu.addItem("Tools");
    Menu toolsMenu = new Menu(220, 20);
    secondMenu.addMenutoItem(toolsMenu, "Tools");
    toolsMenu.addItem("Apply Filter");
    toolsMenu.addItem("Add Text");
    toolsMenu.addItem("Draw");
    toolsMenu.addItem("Erase");
    toolsMenu.addItem("Zoom In");
    toolsMenu.addItem("Zoom Out");

    // Layer Management
    secondMenu.addItem("Layer");
    Menu layerManagementMenu = new Menu(220, 20);
    secondMenu.addMenutoItem(layerManagementMenu, "Layer");
    layerManagementMenu.addItem("Add Layer");
    layerManagementMenu.addItem("Remove Layer");
    layerManagementMenu.addItem("Merge Layers");
    layerManagementMenu.addItem("Flatten Image");

    for (MenuItem i : secondMenu.items) {
        i.isShown = true;
    }
}

void setupThirdMenu() {
    // Initialize the thirdMenu as the first flat menu
    thirdMenu = new Menu(20, 20);
    // Assuming itemNames2 is an array and has at least 30 items
    for (int i = 0; i < 30; i++) {
        thirdMenu.addItem(itemNames2[i]);
    }
    // Ensuring all items are set to be shown
    for (MenuItem item : thirdMenu.items) {
        item.isShown = true;
    }

    // Initialize the thirdMenu2 as the second flat menu, positioned next to the first
    thirdMenu2 = new Menu(250, 20); // Adjust the x position as necessary to place it beside the first menu
    // Assuming itemNames2 has at least 60 items to accommodate indices up to 59
    for (int i = 30; i < 60; i++) {
        thirdMenu2.addItem(itemNames2[i]);
    }
    // Ensuring all items in the second menu are also set to be shown
    for (MenuItem item : thirdMenu2.items) {
        item.isShown = true;
    }
}

void setupFourthMenu() {
    fourthMenu = new Menu(20, 20);

    // Assuming addMenutoItem adds a submenu to an item in the parent menu
    // and that it correctly nests the menu structure for display

    // File Operations
    Menu fileOperationsMenu = addSubMenu("File Operations", new String[]{"New File", "Open File", "Import", "Print", "Convert to Format", "Save", "Save As", "Export"});
    
    // Edit Operations
    Menu editOperationsMenu = addSubMenu("Edit Operations", new String[]{"Crop", "Resize", "Rotate", "Undo", "Redo", "Cut", "Copy", "Paste"});
    
    // Image Adjustments
    Menu imageAdjustmentsMenu = addSubMenu("Image Adjustments", new String[]{"Brightness Adjustment", "Contrast Adjustment", "Saturation Adjustment", "Hue Adjustment", "Adjust Levels", "Curves Adjustment", "Color Balance"});
    
    // Tools
    Menu toolsMenu = addSubMenu("Accessory Tools", new String[]{"Draw", "Erase", "Add Text", "Apply Filter", "Clone Stamp", "Healing Brush", "Pen Tool", "Lasso Tool", "Pen Tool", "Gradient Tool", "Text Tool", "Bucket Fill", "Brush Tool", "History Brush", "Dodge Tool", "Burn Tool", "Sponge Tool", "Sharpen", "Blur", "Rectangle Tool", "Ellipse Tool", "Zoom In", "Zoom Out"});
    
    // Layer Management
    Menu layerManagementMenu = addSubMenu("Layer Management", new String[]{"Add Layer", "Remove Layer", "Merge Layers", "Flatten Image", "Align Layers", "Distribute Layers"});
    
    // Selection Tools
    Menu selectionToolsMenu = addSubMenu("Selections", new String[]{"Magic Wand", "Lasso Tool", "Select", "Deselect", "Invert Selection", "Path Selection", "Direct Selection"});
    
    // Transformation Tools
    Menu transformationToolsMenu = addSubMenu("Transformations", new String[]{"Free Transform", "Perspective Transform", "Warp Transform"});
    
    // Adding submenus to the main menu
    fourthMenu.addMenutoItem(fileOperationsMenu, "File Operations");
    fourthMenu.addMenutoItem(imageAdjustmentsMenu, "Image Adjustments");
    fourthMenu.addMenutoItem(editOperationsMenu, "Edit Operations");
    fourthMenu.addMenutoItem(toolsMenu, "Accessory Tools");
    fourthMenu.addMenutoItem(transformationToolsMenu, "Transformations");
    fourthMenu.addMenutoItem(layerManagementMenu, "Layer Management");
    fourthMenu.addMenutoItem(selectionToolsMenu, "Selections");

    for (MenuItem i : fourthMenu.items) {
        i.isShown = true;
    }
}

void setupFifthMenu() {
    fifthMenu = new Menu(20, 20);

    // File
    Menu fileMenu = new Menu(220, 20);
    fifthMenu.addItem("File");
    fifthMenu.addMenutoItem(fileMenu, "File");
    // Adding items to File menu
    fileMenu.addItem("New File");
    fileMenu.addItem("Open File");
    fileMenu.addItem("Import");
    fileMenu.addItem("Print");
    fileMenu.addItem("Convert to Format");
    Menu saveOptionsMenu = new Menu(320, 20);
    fileMenu.addItem("Save Options");
    fileMenu.addMenutoItem(saveOptionsMenu, "Save Options");
    saveOptionsMenu.addItem("Save");
    saveOptionsMenu.addItem("Save As");
    fileMenu.addItem("Export");

    // Image
    Menu imageMenu = new Menu(220, 20);
    fifthMenu.addItem("Image");
    fifthMenu.addMenutoItem(imageMenu, "Image");
    // Adjustments
    Menu adjustmentsMenu = new Menu(320, 20);
    imageMenu.addItem("Adjustments");
    imageMenu.addMenutoItem(adjustmentsMenu, "Adjustments");
    adjustmentsMenu.addItem("Brightness Adjustment");
    adjustmentsMenu.addItem("Contrast Adjustment");
    adjustmentsMenu.addItem("Saturation Adjustment");
    adjustmentsMenu.addItem("Hue Adjustment");
    // Other Image adjustments
    imageMenu.addItem("Adjust Levels");
    imageMenu.addItem("Curves Adjustment");
    imageMenu.addItem("Color Balance");
    imageMenu.addItem("Flatten Image");

    // Edit
    Menu editMenu = new Menu(220, 20);
    fifthMenu.addItem("Edit");
    fifthMenu.addMenutoItem(editMenu, "Edit");
    // Edit operations
    editMenu.addItem("Modifications");
    Menu modificationsMenu = new Menu(320, 20);
    editMenu.addMenutoItem(modificationsMenu, "Modifications");
    modificationsMenu.addItem("Crop");
    modificationsMenu.addItem("Resize");
    modificationsMenu.addItem("Rotate");
    // Clipboard operations
    editMenu.addItem("Clipboard");
    Menu clipboardMenu = new Menu(320, 20);
    editMenu.addMenutoItem(clipboardMenu, "Clipboard");
    clipboardMenu.addItem("Copy");
    clipboardMenu.addItem("Cut");
    clipboardMenu.addItem("Paste");
    // History
    editMenu.addItem("Undo");
    editMenu.addItem("Redo");

    // Layer Management
    Menu layerMenu = new Menu(220, 20);
    fifthMenu.addItem("Layer Management");
    fifthMenu.addMenutoItem(layerMenu, "Layer Management");
    // Layer operations
    layerMenu.addItem("Layer Modifications");
    Menu layerModificationsMenu = new Menu(320, 20);
    layerMenu.addMenutoItem(layerModificationsMenu, "Layer Modifications");
    layerModificationsMenu.addItem("Align Layers");
    layerModificationsMenu.addItem("Distribute Layers");
    layerModificationsMenu.addItem("Merge Layers");
    layerMenu.addItem("Add Layer");
    layerMenu.addItem("Remove Layer");

    // Selection Operations
    Menu selectionMenu = new Menu(220, 20);
    fifthMenu.addItem("Selection Operations");
    fifthMenu.addMenutoItem(selectionMenu, "Selection Operations");
    // Selection actions
    selectionMenu.addItem("Select");
    selectionMenu.addItem("Deselect");
    selectionMenu.addItem("Invert Selection");
    // Selection methods
    selectionMenu.addItem("Selection Methods");
    Menu selectionMethodsMenu = new Menu(320, 20);
    selectionMenu.addMenutoItem(selectionMethodsMenu, "Selection Methods");
    selectionMethodsMenu.addItem("Path Selection");
    selectionMethodsMenu.addItem("Direct Selection");
    selectionMethodsMenu.addItem("Magic Wand");
    selectionMethodsMenu.addItem("Lasso Tool");

    // Transformation Methods
    Menu transformationMenu = new Menu(220, 20);
    fifthMenu.addItem("Transformation");
    fifthMenu.addMenutoItem(transformationMenu, "Transformation");
    transformationMenu.addItem("Free Transform");
    transformationMenu.addItem("Perspective Transform");
    transformationMenu.addItem("Wrap Transform");

    fifthMenu.addItem("Tools");
    Menu toolsMenu = new Menu(220, 20);
    fifthMenu.addMenutoItem(toolsMenu, "Tools");

    // Zoom Submenu
    toolsMenu.addItem("Zoom");
    Menu zoomMenu = new Menu(320, 20);
    toolsMenu.addMenutoItem(zoomMenu, "Zoom");
    zoomMenu.addItem("Zoom In");
    zoomMenu.addItem("Zoom Out");

    // Text Submenu
    toolsMenu.addItem("Text");
    Menu textMenu = new Menu(320, 20);
    toolsMenu.addMenutoItem(textMenu, "Text");
    textMenu.addItem("Add Text");
    textMenu.addItem("Text Tool");

    // Effect Submenu
    toolsMenu.addItem("Effect");
    Menu effectMenu = new Menu(320, 20);
    toolsMenu.addMenutoItem(effectMenu, "Effect");
    effectMenu.addItem("Blur");
    effectMenu.addItem("Sharpen");
    effectMenu.addItem("Apply Filter");

    // Sketch Submenu
    toolsMenu.addItem("Sketch");
    Menu sketchMenu = new Menu(320, 20);
    toolsMenu.addMenutoItem(sketchMenu, "Sketch");
    sketchMenu.addItem("Draw");
    sketchMenu.addItem("Pen Tool");
    sketchMenu.addItem("Bucket Fill");
    sketchMenu.addItem("Bucket Tool");

    // Directly adding items to the Tools menu for the remaining tools
    toolsMenu.addItem("Erase");
    toolsMenu.addItem("Apply Filter");
    toolsMenu.addItem("Clone Stamp");
    toolsMenu.addItem("Healing Brush");
    toolsMenu.addItem("Gradient Tool");
    toolsMenu.addItem("History Brush");
    toolsMenu.addItem("Dodge Tool");
    toolsMenu.addItem("Burn Tool");
    toolsMenu.addItem("Sponge Tool");
    toolsMenu.addItem("Rectangle Tool");
    toolsMenu.addItem("Ellipse Tool");
    
    for (MenuItem i : fifthMenu.items) {
        i.isShown = true;
    }
}



Menu addSubMenu(String title, String[] items) {
    Menu menu = new Menu(220, 20);
    fourthMenu.addItem(title);
    for (String item : items) {
        menu.addItem(item);
    }
    return menu;
}