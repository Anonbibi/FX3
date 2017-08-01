var hat = {
    man: [0,2, 4, 5, 6, 7, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 25, 26, 27, 28, 29, 30, 31, 44, 45, 48, 49, 50, 51, 52, 53, 54, 55, 56, 58, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81, 82],
    woman: [0,4, 5, 6, 7, 9, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 26, 27, 28, 29, 43, 44, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 81]
};

var glasses = {
    man: [0,3,4,5,7,8,9,10,12,13,15,16,17,18,19,20],
    woman: [0,1,2,3,4,6,7,8,9,10,11,14,16,17,18,19,20,21]
};
var clothesShopMenu = {
    currentBtn:1,
    maxOutfits: 0,
    outfitList: [],
    menu: {
        main: {
            title: 'Vêtements',
            slug: 'main',
            last: 'close',
            buttons:[
                {
                    id: 1,
                    title:  'Achat de tenue',
                    slug:   'outfits'
                },
                {
                    id: 2,
                    title:  'Achat de chapeaux',
                    slug:   'hat'
                },
                {
                    id: 3,
                    title:  'Achat de lunettes',
                    slug:   'glasses'
                },
                {
                    id: 4,
                    title:  ' ',
                    slug:   'spacer'
                },
                {
                    id: 5,
                    title:  'S\'habiller',
                    slug:   'dressing'
                },
                {
                    id: 6,
                    title:  'Changer de lunette',
                    slug:   'dressingGlasses'
                },
                {
                    id: 6,
                    title:  'Changer de chapeau',
                    slug:   'dressingHats'
                }
            ]
        },
        outfits :{
            title:  'Tenues',
            last:   'main',
            buttons:[]
        },
        hats :{
            title:  'Chapeaux',
            last:   'main',
            buttons:[]
        },
        glasses :{
            title:  'Lunettes',
            last:   'main',
            buttons:[]
        },
        dressing :{
            title:  'S habiller',
            last:   'main',
            buttons:[]
        },
        dressingGlasses : {
            title:  'Mes lunettes',
            last:   'main',
            buttons:[]
        },
        dressingHats : {
            title:  'Mes chapeaux',
            last:   'main',
            buttons:[]
        }
    }
};

$(document).ready(function(){

    function openMain() {
        // Toggle Menu show/hidden
        $(".container").addClass("open");
        $(".menu").addClass("main");
        $('.menu_title').html(clothesShopMenu.menu.main.title);
        for (var i = 0; i < 11; i++) {
            var e = "<li data-position="+i+" data-id='"+clothesShopMenu.menu.main.buttons[i].id+"' data-slug='" +clothesShopMenu.menu.main.buttons[i].slug + "'> "+clothesShopMenu.menu.main.buttons[i].title+"</li>";
            $('.buttons').append(e)
        }
        $('.buttons li:nth-child(1)').addClass('active');
    }

    function openOutfits() {
        $(".container").addClass("open");
        $(".menu").addClass("outfits");
        $('.menu_title').html(clothesShopMenu.menu.outfits.title);
        for (var i = 0; i < 11; i++) {
            var e = "<li data-position="+i+" data-id='"+clothesShopMenu.menu.outfits.buttons[i].id+"' data-price="+clothesShopMenu.menu.outfits.buttons[i].price+"> "+clothesShopMenu.menu.outfits.buttons[i].title+" <span class='price'>"+ clothesShopMenu.menu.outfits.buttons[i].price +"€</span></li>";
            $('.buttons').append(e)
        }
        $('.buttons li:nth-child(1)').addClass('active');
    }
    function openDressing() {
        $(".container").addClass("open");
        $(".menu").addClass("dressing");
        $('.menu_title').html(clothesShopMenu.menu.dressing.title);
        for (var i = 0; i < 11; i++) {
            var e = "<li data-position="+i+" data-id='"+clothesShopMenu.menu.dressing.buttons[i].id+"'> "+clothesShopMenu.menu.dressing.buttons[i].title +" <span class='price'>Porter</span></li>";
            $('.buttons').append(e)
        }
        $('.buttons li:nth-child(1)').addClass('active');
    }
    function openHats() {
        $(".container").addClass("open");
        $(".menu").addClass("hats");
        $('.menu_title').html(clothesShopMenu.menu.hats.title);
        for (var i = 0; i < 11; i++) {
            var e = "<li data-position="+i+" data-id='"+clothesShopMenu.menu.hats.buttons[i].id+"'  data-price="+clothesShopMenu.menu.hats.buttons[i].price+"  data-slug='" +clothesShopMenu.menu.hats.buttons[i].slug + "'> "+clothesShopMenu.menu.hats.buttons[i].title+" <span class='price'>"+ clothesShopMenu.menu.hats.buttons[i].price +"€</span></li>";
            $('.buttons').append(e)
        }
        $('.buttons li:nth-child(1)').addClass('active');
    }
    function openGlasses() {
        $(".container").addClass("open");
        $(".menu").addClass("glasses");
        $('.menu_title').html(clothesShopMenu.menu.glasses.title);
        for (var i = 0; i < 11; i++) {
            var e = "<li data-position="+i+" data-id="+clothesShopMenu.menu.glasses.buttons[i].id+" data-price="+clothesShopMenu.menu.glasses.buttons[i].price+" data-slug='" +clothesShopMenu.menu.glasses.buttons[i].slug +"'> "+clothesShopMenu.menu.glasses.buttons[i].title+" <span class='price'>"+ clothesShopMenu.menu.glasses.buttons[i].price +"€</span></li>";
            $('.buttons').append(e)
        }
        $('.buttons li:nth-child(1)').addClass('active');
    }

    function openDressingGlasses() {
        $(".container").addClass("open");
        $(".menu").addClass("dressingGlasses");
        $('.menu_title').html(clothesShopMenu.menu.dressingGlasses.title);
        for (var i = 0; i < 11; i++) {
            var e = "<li data-position="+i+" data-id='"+clothesShopMenu.menu.dressingGlasses.buttons[i].id+"'> "+clothesShopMenu.menu.dressingGlasses.buttons[i].title +" <span class='price'>Porter</span></li>";
            $('.buttons').append(e)
        }
        $('.buttons li:nth-child(1)').addClass('active');
    }

    function openDressingHats() {
        $(".container").addClass("open");
        $(".menu").addClass("dressingHats");
        $('.menu_title').html(clothesShopMenu.menu.dressingHats.title);
        for (var i = 0; i < 11; i++) {
            var e = "<li data-position="+i+" data-id='"+clothesShopMenu.menu.dressingHats.buttons[i].id+"'> "+clothesShopMenu.menu.dressingHats.buttons[i].title +" <span class='price'>Porter</span></li>";
            $('.buttons').append(e)
        }
        $('.buttons li:nth-child(1)').addClass('active');
    }

    function resetMenu() {
        $(".container").removeClass("open");
        $('.menu_title').html(" ");
        $('.menu').removeClass('main outfits hats glasses dressing dressingGlasses dressingHats');
        $('.buttons').html(' ');
    }

    window.addEventListener('message', function(e) {
        if ( e.data.openMain )      { openMain(); }
        if ( e.data.openUI )        { openMain(); }
        if ( e.data.closeUI )       { resetMenu(); }
        if ( e.data.outfitsList )   {
            var list = JSON.parse(e.data.outfitsList);
            for (var i = 0; i < list.length; i++) {
                clothesShopMenu.menu.outfits.buttons[i] = {
                    title:      list[i].name,
                    slug:       list[i].category,
                    id:         i + 1,
                    price:      list[i].price
                }
            }
        }
        if ( e.data.hatsList )   {
            var plist = JSON.parse(e.data.hatsList);
            for (var a = 0; a < plist.length; a++) {
                clothesShopMenu.menu.hats.buttons[a] = {
                    title:      'Chapeau n°'+ plist[a].item_id,
                    slug:       plist[a].category,
                    id:         plist[a].item_id,
                    price:      plist[a].price
                }
            }
        }
        if ( e.data.glassesList )   {
            var plist = JSON.parse(e.data.glassesList);
            for (var a = 0; a < plist.length; a++) {
                clothesShopMenu.menu.glasses.buttons[a] = {
                    title:      'Lunette n°'+ plist[a].item_id,
                    slug:       plist[a].category,
                    id:         plist[a].item_id,
                    price:      plist[a].price
                }
            }
        }
        if ( e.data.dressingList )   {
            var dlist = JSON.parse(e.data.dressingList);
            for (var b = 0; b < dlist.length; b++) {
                clothesShopMenu.menu.dressing.buttons[b] = {
                    title:      dlist[b].name,
                    slug:       dlist[b].category,
                    id:         b + 1,
                    price:      null
                }
            }
        }
        if ( e.data.dressingGlassesList )   {
            var dlist = JSON.parse(e.data.dressingGlassesList);
            for (var i = 0; i < dlist.length; i++) {
                clothesShopMenu.menu.dressingGlasses.buttons[i] = {
                    title:      'Lunette n°'+dlist[i].item_id,
                    slug:       dlist[i].category,
                    id:         i + 1,
                    price:      null
                }
            }
        }
        if ( e.data.dressingHatsList )   {
            var dlist = JSON.parse(e.data.dressingHatsList);
            for (var i = 0; i < dlist.length; i++) {
                clothesShopMenu.menu.dressingHats.buttons[i] = {
                    title:      'Chapeau n°'+dlist[i].item_id,
                    slug:       dlist[i].category,
                    id:         i + 1,
                    price:      null
                }
            }
        }

    });

    document.onkeyup = function (keys) {
        if ( keys.which == 21 ) {
            resetMenu();
            $.post('http://clotheshop/close', JSON.stringify({}));
        }
        //back
        if ( keys.which == 8 ) {
            if ( $('.menu').hasClass('outfits') ) {
                resetMenu();
                setTimeout(function(){
                    openMain()
                }, 400);
            } else if ( $('.menu').hasClass('hats') ) {
                resetMenu();
                setTimeout(function(){
                    openMain()
                }, 400);
            } else if ( $('.menu').hasClass('glasses') ) {
                resetMenu();
                setTimeout(function(){
                    openMain()
                }, 400);
            }
            else {
                $.post('http://clotheshop/close', JSON.stringify({}));
            }
        }
        // ENTER
        if ( keys.which == 13 ) {
            // Menu Tenue action de payer
            if ( $('.menu').hasClass('outfits') ) {
                $.post('http://clotheshop/outfit_pay', JSON.stringify({id: $('.buttons li.active').data('id'), price: $('.buttons li.active').data('price') }))
            }
            // Menu S habiller action de porter
            if ( $('.menu').hasClass('dressing')) {

                $.post('http://clotheshop/outfit_wear', JSON.stringify({id: $('.buttons li.active').data('id') }));
            }

            // Menu des lunettes action d'acheter
            if ( $('.menu').hasClass('glasses') ) {
                $.post('http://clotheshop/prop_pay', JSON.stringify({id: $('.buttons li.active').data('position') +1, price: $('.buttons li.active').data('price'), category: $('.buttons li.active').data('slug') }))
            }
            // Menu des chapeaux action d'acheter
            if ( $('.menu').hasClass('hats') ) {
                $.post('http://clotheshop/prop_pay', JSON.stringify({id: $('.buttons li.active').data('position') +1, price: $('.buttons li.active').data('price'), category: $('.buttons li.active').data('slug') }))
            }

            // Menu des
            if ( $('.menu').hasClass('dressingGlasses')) {

                $.post('http://clotheshop/prop_glasses_wear', JSON.stringify({id: $('.buttons li.active').data('id') }));
            }
            if ( $('.menu').hasClass('dressingHats')) {

                $.post('http://clotheshop/prop_hats_wear', JSON.stringify({id: $('.buttons li.active').data('id') }));
            }

            // NAVIGATION HORIZONTAL
            if ( $('.menu').hasClass('main') && $('.buttons li.active').data('slug') == 'outfits') {
                resetMenu();
                setTimeout(function(){
                    openOutfits()
                }, 400);
            }
            if ( $('.menu').hasClass('main') && $('.buttons li.active').data('slug') == 'hat') {
                resetMenu();
                setTimeout(function(){
                    openHats()
                }, 400);
            }
            if ( $('.menu').hasClass('main') && $('.buttons li.active').data('slug') == 'glasses') {
                resetMenu();
                setTimeout(function(){
                    openGlasses()
                }, 400);
            }
            if ( $('.menu').hasClass('main') && $('.buttons li.active').data('slug') == 'dressing') {
                resetMenu();
                setTimeout(function(){
                    openDressing()
                }, 400);
            }
            if ( $('.menu').hasClass('main') && $('.buttons li.active').data('slug') == 'dressingGlasses') {
                resetMenu();
                setTimeout(function(){
                    openDressingGlasses()
                }, 400);
            }
            if ( $('.menu').hasClass('main') && $('.buttons li.active').data('slug') == 'dressingHats') {
                resetMenu();
                setTimeout(function(){
                    openDressingHats()
                }, 400);
            }

        }
        // DOWN
        if ( keys.which == 40 ) {
            var current = $('.buttons li.active');
            if (current.index() + 1 < $('.buttons li').length ) {
                $('.buttons li.active').removeClass('active');
                if ( $('.buttons li:nth-child('+ ( current.index() + 2 ) +')').data('slug')  == 'spacer' ) {
                    $('.buttons li:nth-child('+ ( current.index() + 3 ) +')').addClass('active');
                } else {
                    $('.buttons li:nth-child('+ ( current.index() + 2 ) +')').addClass('active');
                }
            }
            if ( $('.menu').hasClass('outfits') ) {
                if (current.index() +2 > 10 ) {
                    var e = "<li data-position="+ parseInt(current.data('position') +2) +" data-id='"+clothesShopMenu.menu.outfits.buttons[parseInt(current.data('position') +2)].id+"' data-price="+clothesShopMenu.menu.outfits.buttons[parseInt(current.data('position') +2)].price+"> "+clothesShopMenu.menu.outfits.buttons[parseInt(current.data('position') +2)].title+" <span class='price'>"+ clothesShopMenu.menu.outfits.buttons[parseInt(current.data('position') +2)].price +"€</span></li>";
                    $('li:nth-child(0)').remove();
                    $('li:nth-child(1)').remove();

                    $('.buttons').append(e);
                    $.post('http://clotheshop/outfit_switcher', JSON.stringify({id: clothesShopMenu.menu.outfits.buttons[parseInt(current.data('position') + 1)].id}));

                } else {
                    $.post('http://clotheshop/outfit_switcher', JSON.stringify({id: $('.buttons li.active').data('id') }))
                }

            }
            if ( $('.menu').hasClass('dressing') ) {
                if (current.index() +2 > 10 ) {
                    var e = "<li data-position="+ parseInt(current.data('position') +2) +" data-id='"+clothesShopMenu.menu.dressing.buttons[parseInt(current.data('position') +2)].id+"'> "+clothesShopMenu.menu.dressing.buttons[parseInt(current.data('position') +2)].title+" <span class='price'>Porter</span></li>";
                    $('li:nth-child(0)').remove();
                    $('li:nth-child(1)').remove();

                    $('.buttons').append(e);
                    $.post('http://clotheshop/dressing_switcher', JSON.stringify({id: clothesShopMenu.menu.dressing.buttons[parseInt(current.data('position') + 1)].id}));

                } else {
                    $.post('http://clotheshop/dressing_switcher', JSON.stringify({id: $('.buttons li.active').data('id') }))
                }

            }
            if ( $('.menu').hasClass('dressingGlasses') ) {
                if (current.index() +2 > 10 ) {
                    var e = "<li data-position="+ parseInt(current.data('position') +2) +" data-id='"+clothesShopMenu.menu.dressingGlasses.buttons[parseInt(current.data('position') +2)].id+"'> "+clothesShopMenu.menu.dressingGlasses.buttons[parseInt(current.data('position') +2)].title+" <span class='price'>Porter</span></li>";
                    $('li:nth-child(0)').remove();
                    $('li:nth-child(1)').remove();

                    $('.buttons').append(e);
                    $.post('http://clotheshop/glasses_dressing_switcher', JSON.stringify({id: current.data('position') +1}));

                } else {
                    $.post('http://clotheshop/glasses_dressing_switcher', JSON.stringify({id: $('.buttons li.active').data('position') +1 }))
                }

            }
            if ( $('.menu').hasClass('dressingHats') ) {
                if (current.index() +2 > 10 ) {
                    var e = "<li data-position="+ parseInt(current.data('position') +2) +" data-id='"+clothesShopMenu.menu.dressingHats.buttons[parseInt(current.data('position') +2)].id+"'> "+clothesShopMenu.menu.dressingHats.buttons[parseInt(current.data('position') +2)].title+" <span class='price'>Porter</span></li>";
                    $('li:nth-child(0)').remove();
                    $('li:nth-child(1)').remove();

                    $('.buttons').append(e);
                    $.post('http://clotheshop/hats_dressing_switcher', JSON.stringify({id: current.data('position') +1}));

                } else {
                    $.post('http://clotheshop/hats_dressing_switcher', JSON.stringify({id: $('.buttons li.active').data('position') +1 }))
                }

            }
            if ( $('.menu').hasClass('hats') ) {
                if (current.index() +2 > 10 ) {
                    var e = "<li data-position="+ parseInt(current.data('position') +2) +" data-id='"+clothesShopMenu.menu.hats.buttons[parseInt(current.data('position') +2)].id+"' data-price="+clothesShopMenu.menu.hats.buttons[parseInt(current.data('position') +2)].price+"  data-slug='" +clothesShopMenu.menu.hats.buttons[parseInt(current.data('position') +2)].slug + "'> "+clothesShopMenu.menu.hats.buttons[parseInt(current.data('position') +2)].title+" <span class='price'>"+ clothesShopMenu.menu.hats.buttons[parseInt(current.data('position') +2)].price +"€</span></li>";
                    $('li:nth-child(0)').remove();
                    $('li:nth-child(1)').remove();

                    $('.buttons').append(e);
                    $.post('http://clotheshop/hat_switcher', JSON.stringify({id: clothesShopMenu.menu.hats.buttons[parseInt(current.data('position') + 1)].id}));

                } else {
                    $.post('http://clotheshop/hat_switcher', JSON.stringify({id: $('.buttons li.active').data('id')}));
                }
            }
            if ( $('.menu').hasClass('glasses') ) {
                if (current.index() +2 > 10 ) {
                    var e = "<li data-position="+ parseInt(current.data('position') +2) +" data-id='"+clothesShopMenu.menu.glasses.buttons[parseInt(current.data('position') +2)].id+"'  data-price="+clothesShopMenu.menu.glasses.buttons[parseInt(current.data('position') +2)].price+"  data-slug='" +clothesShopMenu.menu.glasses.buttons[parseInt(current.data('position') +2)].slug + "'> "+clothesShopMenu.menu.glasses.buttons[parseInt(current.data('position') +2)].title+" <span class='price'>"+ clothesShopMenu.menu.glasses.buttons[parseInt(current.data('position') +2)].price +"€</span></li>";
                    $('li:nth-child(0)').remove();
                    $('li:nth-child(1)').remove();

                    $('.buttons').append(e);
                    $.post('http://clotheshop/glasses_switcher', JSON.stringify({id: clothesShopMenu.menu.glasses.buttons[parseInt(current.data('position') + 1)].id}));

                } else {
                    $.post('http://clotheshop/glasses_switcher', JSON.stringify({id: $('.buttons li.active').data('id')}));
                }
            }
        }
        // UP
        if ( keys.which == 38 ) {
            var current = $('.buttons li.active');
            if (current.index() - 1 <= $('.buttons li').length ) {
                $('.buttons li.active').removeClass('active');
                //$('.buttons li:nth-child('+ ( current.index() ) +')').addClass('active')
                if ( $('.buttons li:nth-child('+ ( current.index()) +')').data('slug')  == 'spacer' ) {
                    $('.buttons li:nth-child('+ ( current.index() - 1 ) +')').addClass('active');
                } else {
                    $('.buttons li:nth-child('+ ( current.index()) +')').addClass('active');
                }
            }
            if ( $('.menu').hasClass('outfits') ) {
                if (current.index() - 2 < 0 ) {
                    var e = "<li data-position="+ parseInt(current.data('position')- 2) +" data-id='"+clothesShopMenu.menu.outfits.buttons[parseInt(current.data('position') - 2)].id+"' data-price="+clothesShopMenu.menu.outfits.buttons[parseInt(current.data('position') -2)].price+"> "+clothesShopMenu.menu.outfits.buttons[parseInt(current.data('position') - 2)].title+" <span class='price'>"+ clothesShopMenu.menu.outfits.buttons[parseInt(current.data('position')- 2)].price +"€</span></li>";
                    $('li:nth-child(11)').remove();
                    $('li:nth-child(12)').remove();

                    $('.buttons').prepend(e);
                    $.post('http://clotheshop/outfit_switcher', JSON.stringify({id: clothesShopMenu.menu.outfits.buttons[parseInt(current.data('position') - 1)].id}));

                } else {
                    $.post('http://clotheshop/outfit_switcher', JSON.stringify({id: $('.buttons li.active').data('id')}));

                }
            }
            if ( $('.menu').hasClass('dressing') ) {
                if (current.index() +2 > 10 ) {
                    var e = "<li data-position="+ parseInt(current.data('position') -2) +" data-id='"+clothesShopMenu.menu.dressing.buttons[parseInt(current.data('position') -2)].id+"'> "+clothesShopMenu.menu.dressing.buttons[parseInt(current.data('position') -2)].title+" <span class='price'>Porter</span></li>";
                    $('li:nth-child(11)').remove();
                    $('li:nth-child(12)').remove();
                    $('.buttons').append(e);
                    $.post('http://clotheshop/dressing_switcher', JSON.stringify({id: clothesShopMenu.menu.dressing.buttons[parseInt(current.data('position') - 1)].id}));
                } else {
                    $.post('http://clotheshop/dressing_switcher', JSON.stringify({id: $('.buttons li.active').data('id') }))
                }

            }
            if ( $('.menu').hasClass('dressingGlasses') ) {
                if (current.index() +2 > 10 ) {
                    var e = "<li data-position="+ parseInt(current.data('position') -2) +" data-id='"+clothesShopMenu.menu.dressingGlasses.buttons[parseInt(current.data('position') -2)].id+"'> "+clothesShopMenu.menu.dressingGlasses.buttons[parseInt(current.data('position') -2)].title+" <span class='price'>Porter</span></li>";
                    $('li:nth-child(11)').remove();
                    $('li:nth-child(12)').remove();
                    $('.buttons').append(e);
                    $.post('http://clotheshop/glasses_dressing_switcher', JSON.stringify({id: current.data('position') +1}));
                } else {
                    $.post('http://clotheshop/glasses_dressing_switcher', JSON.stringify({id: $('.buttons li.active').data('position') +1 }))
                }

            }
            if ( $('.menu').hasClass('dressingHats') ) {
                if (current.index() +2 > 10 ) {
                    var e = "<li data-position="+ parseInt(current.data('position') -2) +" data-id='"+clothesShopMenu.menu.dressingHats.buttons[parseInt(current.data('position') -2)].id+"'> "+clothesShopMenu.menu.dressingHats.buttons[parseInt(current.data('position') -2)].title+" <span class='price'>Porter</span></li>";
                    $('li:nth-child(11)').remove();
                    $('li:nth-child(12)').remove();
                    $('.buttons').append(e);
                    $.post('http://clotheshop/hats_dressing_switcher', JSON.stringify({id: current.data('position') +1}));
                } else {
                    $.post('http://clotheshop/hats_dressing_switcher', JSON.stringify({id: $('.buttons li.active').data('position') +1 }))
                }

            }

            if ( $('.menu').hasClass('hats') ) {

                if (current.index() - 2 < 0 ) {
                    var e = "<li data-position="+ parseInt(current.data('position')- 2) +" data-id='"+clothesShopMenu.menu.hats.buttons[parseInt(current.data('position') - 2)].id+"' data-price="+clothesShopMenu.menu.hats.buttons[parseInt(current.data('position') -2)].price+"  data-slug='" +clothesShopMenu.menu.hats.buttons[parseInt(current.data('position') -2)].slug + "'> "+clothesShopMenu.menu.hats.buttons[parseInt(current.data('position') - 2)].title+" <span class='price'>"+ clothesShopMenu.menu.hats.buttons[parseInt(current.data('position')- 2)].price +"€</span></li>";
                    $('li:nth-child(11)').remove();
                    $('li:nth-child(12)').remove();

                    $('.buttons').prepend(e);
                    $.post('http://clotheshop/hat_switcher', JSON.stringify({id: clothesShopMenu.menu.hats.buttons[parseInt(current.data('position') - 1)].id}));

                } else {
                    $.post('http://clotheshop/hat_switcher', JSON.stringify({id: $('.buttons li.active').data('id')}));

                }

            }
            if ( $('.menu').hasClass('glasses') ) {
                if (current.index() - 2 < 0 ) {
                    var e = "<li data-position="+ parseInt(current.data('position')- 2) +" data-id='"+clothesShopMenu.menu.glasses.buttons[parseInt(current.data('position') - 2)].id+"' data-price="+clothesShopMenu.menu.hats.buttons[parseInt(current.data('position') -2)].price+"  data-slug='" +clothesShopMenu.menu.hats.buttons[parseInt(current.data('position') -2)].slug + "'> "+clothesShopMenu.menu.glasses.buttons[parseInt(current.data('position') - 2)].title+" <span class='price'>"+ clothesShopMenu.menu.glasses.buttons[parseInt(current.data('position')- 2)].price +"€</span></li>";
                    $('li:nth-child(11)').remove();
                    $('li:nth-child(12)').remove();

                    $('.buttons').prepend(e);
                    $.post('http://clotheshop/glasses_switcher', JSON.stringify({id: clothesShopMenu.menu.glasses.buttons[parseInt(current.data('position') - 1)].id}));

                } else {
                    $.post('http://clotheshop/glasses_switcher', JSON.stringify({id: $('.buttons li.active').data('id')}));

                }
            }
        }
    }
});
