import "phoenix_html"
import Elm from './elm.js'

const elmContainer = document.querySelector("#elm-container")

if(elmContainer)  {
	const elmApplication = Elm.Main.embed(elmContainer);
}