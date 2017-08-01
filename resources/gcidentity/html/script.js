GUIAction = {
    closeGui () {
        $('#identity').css("display", "none");
        $('#register').css("display", "none");
        $("#cursor").css("display", "none");
    },
    openGuiIdentity (data) {
        data = data || {}
        let infoMissing = 'Non renseigné'
        if (data.dateNaissance) {
            data.dateNaissance = data.dateNaissance.substr(0,11)
        }
        if (data.sexe !== undefined) {
            $('#identity').css('background-image', "url('ci_" + data.sexe +".png')")
            data.sexe = data.sexe === 'h' ? 'Homme' : 'Femme'
        }
		// color
		if(data.permisvoiture == 'Non Acquis') {
		$('#permisvoiture').css('color', 'red')
		}
		if(data.permisbateaux == 'Non Acquis') {
		$('#permisbateaux').css('color', 'red')
		}
		if(data.permishelico == 'Non Acquis') {
		$('#permishelico').css('color', 'red')
		}
		if(data.permisavion == 'Non Acquis') {
		$('#permisavion').css('color', 'red')
		}
		if(data.portarmeleg == 'Non Acquis') {
		$('#portarmeleg').css('color', 'red')
		}
		if(data.portarmelourd == 'Non Acquis') {
		$('#portarmelourd').css('color', 'red')
		}
		if(data.licencegrandbandi == 'Non Acquis') {
		$('#licencegrandbandi').css('color', 'red')
		}
		// color
		if(data.permisvoiture == 'Acquis') {
		$('#permisvoiture').css('color', 'green')
		}
		if(data.permisbateaux == 'Acquis') {
		$('#permisbateaux').css('color', 'green')
		}
		if(data.permishelico == 'Acquis') {
		$('#permishelico').css('color', 'green')
		}
		if(data.permisavion == 'Acquis') {
		$('#permisavion').css('color', 'green')
		}
		if(data.portarmeleg == 'Acquis') {
		$('#portarmeleg').css('color', 'green')
		}
		if(data.portarmelourd == 'Acquis') {
		$('#portarmelourd').css('color', 'green')
		}
		if(data.licencegrandbandi == 'Acquis') {
		$('#licencegrandbandi').css('color', 'green')
		}
        if (data.taille !== undefined){
            data.taille = data.taille + ' cm'
        }
        ['nom','prenom','jobs', 'dateNaissance', 'sexe', 'taille', 'permisvoiture', 'permisbateaux', 'permishelico', 'permisavion', 'portarmeleg', 'portarmelourd', 'licencegrandbandi',].forEach(k => {
            $('#'+k).text(data[k] || infoMissing)
        })

        let numCarte = "IDLO$<<<<<<<<<<<<<<<<<<<<<<<<<<<<654899<br>" 
        numCarte += (data.nom || 'UnKo').substr(0, 4) 
        numCarte += (data.dateNaissance || '0000001900').substr(6,4)
        numCarte += "587<<<<<95GFAV7Vh4"

        $('#numCarte').html(numCarte)
        

        $('#identity').css("display", "block");
    },
    openGuiRegisterIdentity () {
        $("#cursor").css("display", "block");
        $('#register').css("display", "flex");
    },
    clickGui () {
        var element = $(document.elementFromPoint(cursorX, cursorY))
        element.focus().click()
    }
}

window.addEventListener('message', function (event){
    let method = event.data.method
    if (GUIAction[method] !== undefined) {
        GUIAction[method](event.data.data)
    }
})


$(document).ready(function () {
    $('#register').submit(function (event) {
        event.preventDefault()
        let form = event.target
        let data = {}
        let attrs = ['nom', 'prenom', 'dateNaissance', 'sexe', 'taille']
        attrs.forEach(e => {
            data[e] = form.elements[e].value
        })
        data.dateNaissance = data.dateNaissance.split('/').reverse().join('-')
        $.post('http://gcidentity/register', JSON.stringify(data))
    })
})

//
// Gestion de la souris
//
$(document).ready(function(){
    var documentWidth = document.documentElement.clientWidth
    var documentHeight = document.documentElement.clientHeight
    var cursor = $('#cursor')
    cursorX = documentWidth / 2
    cursorY = documentHeight / 2
    cursor.css('left', cursorX)
    cursor.css('top', cursorY)
    $(document).mousemove( function (event) {
        cursorX = event.pageX
        cursorY = event.pageY
        cursor.css('left', cursorX + 1)
        cursor.css('top', cursorY + 1)
    })
})