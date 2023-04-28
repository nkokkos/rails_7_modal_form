import { Controller } from "@hotwired/stimulus"
import { get }        from '@rails/request.js'
import TomSelect      from "tom-select"

// Connects to data-controller="search"
export default class extends Controller {
  static values = { url: String }

  connect() {
    this.element.setAttribute( "autocomplete", "off" );

    var config = {
      plugins: ['clear_button', 'remove_button'],
      options: [],
      shouldLoad:function(q){
        //console.log("should load");
        return q.length > 2;
      },
      render: {
        option: this.render_option,
        //item: this.render_option
        item: function(data, escape) {
	  return `<div>${escape(data.last_name)}</div>`
        }
      },
      loadThrottle: 300,
      // check this out in search items reload new data->
      // https://github.com/orchidjs/tom-select/issues/78
      // https://stackoverflow.com/questions/74622800/fetching-data-from-api-to-create-tom-select-options
      maxItems: 10,
      maxOptions: 10,
      valueField: 'id',
      labelField: 'first_name',
      searchField: ['first_name', 'last_name','email'],
      //sortField: {
      //  field: "name",
      //  direction: "asc"
      //},
      create: false,
      load: (q, callback) => this.search(q, callback),
     }

    new TomSelect(this.element, config)
  }


  async search(q, callback) {
    const response = await get(this.urlValue, {
      query: { q: q },
      responseKind: 'json'
    })

    if(response.ok) {
     //https://stackoverflow.com/questions/73890677/tomselect-refresh-options-in-dependent-dropdown-after-repeated-ajax-load
     //this.element.clear(); // unselect previously selected elements
     //this.element.clearOptions(); // remove existing options
     //this.element.sync(); // synchronise with the underlying SELECT 
     callback(await response.json)
     this.element.sync();
    } else {
      callback()
    }
  }

  render_option(data, escape) {
    if(data.email)
      return `
      <div>
        <div class="first_name">${escape(data.first_name)}</div>
        <div class="last_name">${escape(data.last_name)}</div>
        <div class="email">${escape(data.email)}</div>
      </div>`
    else
      return `<div>${escape(data.first_name)}</div>`
  }

}
