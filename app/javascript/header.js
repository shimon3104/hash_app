function pullDown() {
  const pullDownButton = document.getElementById("lists")
  const pullDownParents = document.getElementById("pull-down")
  const pullDownChild = document.querySelectorAll(".header-right-content")

  pullDownButton.addEventListener('click',function(){
    if (this.getAttribute("style") == "background-color: #b7fdff;") {
      this.removeAttribute("style", "background-color: #b7fdff;")
    }  else {
      this.setAttribute("style", "background-color: #b7fdff;")
    };
    if (pullDownParents.getAttribute("style") == "display:block;") {
      pullDownParents.removeAttribute("style", "display:block;")
    }  else {
      pullDownParents.setAttribute("style", "display:block;")
    };
  })
}

window.addEventListener('load',pullDown)