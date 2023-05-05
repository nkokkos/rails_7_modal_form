// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"
import * as bootstrap from "bootstrap"
import TomSelect      from "tom-select"

addEventListener("turbo:load", (event) => {

var this_control = new TomSelect("#input-tags",{
	
       onInitialize:function(){
         //alert("hello")
         this.addOption({value: "opt3", text: "Option 3" })
         this.addItem("opt3");	
       },
	createOnBlur: true,
	create: false,
        options: [
	{ value: "opt1", text: "Option 1" },
	{ value: "opt2", text: "Option 2" },
        ],
        items: "opt1"
});

})
