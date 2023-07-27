import {Controller} from "@hotwired/stimulus";

export default class extends Controller {

  navigate(e) {
    let select = e.target
    let path = select.options[select.selectedIndex].value
    Turbo.visit(path)
  }
}
