// assets/js/hooks.js
// for the live button  quick save

export const SaveButtonHook = {
  mounted() {
    this.el.addEventListener("click", () => {
      // const appy = window.appy;  // Assuming `appy` is a global object
      
      // const appy = {name:"neat111", dataarray:[2,3,1,2,1,2,4]};  // Assuming `appy` is a global object
      let dataA = window.paintAppA.drawingData.table.slice();
      if (Array.isArray(dataA)) {
        dataA = dataA.toString();
      }
      // debugger
      console.log("dataA", dataA);
      const appy = {name:"neat111", dataarray:dataA};  // Assuming `appy` is a global object
      this.pushEvent("save_direct", appy);
    });
  }
};


// assets/js/hooks/LoadPaintItems.js
export const LoadPaintItems = {
  mounted() {
    // debugger
    // const imagesDiv = document.getElementById("images");
    const imagesDiv = document.querySelector("#paintingblock #images");
    const paintItems = this.el.dataset.paintitems ? JSON.parse(this.el.dataset.paintitems) : [];
debugger
    paintItems.forEach(item => {
      const itemElement = document.createElement("p");
      itemElement.textContent = `Name: ${item.name}, Dataarray: ${item.dataarray.join(", ")}`;
      imagesDiv.appendChild(itemElement);
    });
  }
};


// Export the hooks
// export default AppyHook;
