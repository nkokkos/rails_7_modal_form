import { Controller } from "@hotwired/stimulus"
import { get }        from '@rails/request.js'
import TomSelect      from "tom-select"

// Connects to data-controller="search"
export default class extends Controller {
  static values = { url: String, selected: String }

  connect() {
    this.element.setAttribute( "autocomplete", "off" );
   
    if (this.selectedValue == 'null') {
      var selected_json_data   = new Array()
      var selected_items_array = new Array();
    } else {
        var selected_json_data = JSON.parse(this.selectedValue)
        var selected_items_array = new Array()
        for(let i = 0; i < selected_json_data.length; i++) {
          selected_items_array.push(selected_json_data[i].id)
        }
    }
    
    var config = {
      plugins: ['clear_button', 'remove_button'],
      shouldLoad:function(q){
        return q.length > 2;
      },
      render: {
        option: this.render_option,
        item: this.render_option
        //item: function(data, escape) {
	//  return `<div>${escape(data.email_address)}</div>`
        //}
      },
      loadThrottle: 300,
      // check this out in search items reload new data->
      // https://github.com/orchidjs/tom-select/issues/78
      // https://stackoverflow.com/questions/74622800/fetching-data-from-api-to-create-tom-select-options
      maxItems: 10,
      maxOptions: 10,
      valueField: 'id',
      labelField: 'email_address',
      searchField: ['email_address', 'first_name', 'last_name'],
      options: selected_json_data,
      items: selected_items_array,
      sortField: {
        field: "email_address",
        direction: "asc"
      },
      create: false,
      load: (q, callback) => this.search(q, callback),
     }
 
    let this_tom_select = new TomSelect(this.element, config)
    this_tom_select.clearCache()
  }


  async search(q, callback) {
    const response = await get(this.urlValue, {
      query: { q: q },
      responseKind: 'json'
    })

    if(response.ok) {
      callback(await response.json)
    } else {
        callback()
    }
  }
  
  render_option(data, escape) {
    if(data.email_address)
      return `
      <div>
        <div class="first_name">${escape(data.email_address)}</div>
        <div class="last_name">${escape(data.first_name)}</div>
        <div class="email_address">${escape(data.last_name)}</div>
      </div>`
    else
      return `<div>${escape(data.first_name)}</div>`
  }

}
