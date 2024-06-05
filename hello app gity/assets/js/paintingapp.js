
// import { PainterApp } from 'https://tripdragon.github.io/cheapyPaint/dist/painterAppModule.1.0.js';
import { PainterApp } from './painterAppModule.2.0.js';
import {Vector2} from './vector2.js';
import { mouseToCanvas, randomHexString } from './utilites.js';




export function buildPaintingApp(){
  // // Get the canvas element
  // var canvas = document.getElementById("paintingcanvas");
  // 
  // // Get the 2D drawing context
  // var ctx = canvas.getContext("2d");
  // 
  // // Set the fill color
  // ctx.fillStyle = "red";
  // 
  // // Draw a rectangle
  // ctx.fillRect(50, 50, 100, 80);

  // debugger
  const configs = {
      brushSize : 1,
      resolution : 400,
      gridUnit : 2*14,
      canvasIdName : "paintingcanvas",
      currentColorHex : "#0000ff"
  }
  
  const ovo = new PainterApp(configs);

  setupMouseEvents_CM(ovo);
  
  setupUI(ovo);
  
  
  
  // document.addEventListener("DOMContentLoaded", () => {
  // 
  //   const imagesDiv = document.querySelector("#paintingblock #images");
  //   if(imagesDiv){
  //     // debugger
  //     const paintItems = <%= raw Jason.encode!(@paintitems) %>;
  //     paintItems.forEach(item => {
  //       const itemElement = document.createElement("p");
  //       itemElement.textContent = `Name: ${item.name}, Dataarray: ${item.dataarray.join(", ")}`;
  //       imagesDiv.appendChild(itemElement);
  //     });
  //   }
  // });
  
  
  return ovo;
  
}



function setupMouseEvents_CM(app){
  
  // var IS_DOWN = false;

  const mouse = new Vector2();
  const mouseDown = new Vector2();
  
  // const _app = app;
  const grid = app.grid;
  const ctx = app.ctx;
  const canvas = app.canvas;
  
  
  
  // canvas.addEventListener( 'pointermove', onPointerMove.bind(app), true );
  // canvas.addEventListener( 'pointerdown', onPointerDown.bind(app), true );
  // canvas.addEventListener( 'pointerup', onPointerUp.bind(app), true );
  canvas.addEventListener( 'pointermove', onPointerMove, true );
  canvas.addEventListener( 'pointerdown', onPointerDown, true );
  canvas.addEventListener( 'pointerup', onPointerUp, true );
  
  // note see that these are nested in the function
  function onPointerMove( ev ) {
    
    if ( !app.IS_DOWN ) {
      // debugger
      return;
    }
    mousing_CM(ev, mouse);
    
    console.log("¿¿¿");
    app.drawFill_222(ev);
    
    // drawGuides();
    
  }
  
  
  function onPointerDown(ev){
    app.IS_DOWN = true;
    mouseToCanvas(ev,mouseDown, app.clientRect);
    mousing_CM(ev);
    
    // for the auto fill system
    mouseToCanvas(ev,app.autoFillMousePositions[0], app.clientRect);
    mouseToCanvas(ev,app.autoFillMousePositions[1], app.clientRect);

    // drawGuides();

  }


  function onPointerUp(ev){
    app.IS_DOWN = false;
    mouseToCanvas(ev,mouse, app.clientRect);
    // drawFill_111(ev);
    
    app.drawFill_222(ev);
    
    // drawGuides();
    console.log("?Up");
    
  }
  
  
  // this handles painting events when mouse is down
  function mousing_CM(ev) {
    // NOTE this function being nested references vars above
    
    // return
    mouseToCanvas(ev,mouse, app.clientRect);
    
    //// drawingData_a.current.reverse();
    // redrawCanvasWithData({width:resolution, height:resolution, gridUnit: gridUnit, context: ctx, dataIn: drawingData_a.current })
    
    let atIndex = grid.getIndexAtMouse(mouse);
    // console.log("atIndex", atIndex);
    // this paints the canvas
    // app.canvasPainter.drawAtIndex(atIndex, grid.unit, grid.width, grid.height, app.ctx, app.currentColor)
    app.canvasPainter.drawAtIndex(atIndex, app.currentColorHex)
    // this sets the database value
    app.drawingData.setTableVal(atIndex, 1);
  }

}



function setupUI(app) {
  

  // const letterinput = document.getElementById('letterinput');

  // const savebutton = document.getElementById('savebutton');
  // savebutton.onclick = function(ev) {
  //   app.generateDataImage();
  //   app.clearScreen_CM();
  // }

  const iterrateSaveButton = document.getElementById('iterrateSaveButton');
  iterrateSaveButton.onclick = function(ev) {
    app.generateDataImage();
  }

  const clearbutton = document.getElementById('clearbutton');
  clearbutton.onclick = function(ev) {
    app.clearScreen_CM();
  }

  const downloadButton = document.getElementById('downloadButton');
  downloadButton.onclick = function(ev) {
    app.saveToFile();
  }

  const dataDownloadButton = document.getElementById('dataDownloadButton');
  dataDownloadButton.onclick = function(ev) {
    app.saveToFileAsDataSize();
  }
  
}
