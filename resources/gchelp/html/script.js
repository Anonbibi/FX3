GUIAction = {
    closeGui () {
        let div = document.querySelectorAll('.help')
		for ( let d of div) {
			d.style.display = "none"
		}
    },
    openGui (data) {
		
        document.querySelector('#' + data.typeHelp ).style.display = "block"
    }
}

window.addEventListener('message', function (event){
    let method = event.data.method
    if (GUIAction[method] !== undefined) {
        GUIAction[method](event.data)
    }
})
