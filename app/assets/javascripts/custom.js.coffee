$ ->
    $.fn.set_autocomplete = ->
        path = this.data('path')
        this.typeahead
            source: this.data('source'),
            updater: (item) ->
                $.ajax path,
                    data:
                        {item: {name: item}}
                return item

    # Autocomplete add

    # Обработчик модального окна
    modal = $('#modal-window') 
    modal.on 'shown', () ->
        $('input[data-provide="typeahead"]').each ->
            $(this).set_autocomplete()

        # Отправка штрихкода или генерация ошибки
        $('#request').submit (e) ->
            barcode = $('#operation_talon_barcode').val()
            show_error "Талон #{barcode} существует в списке" if talon_exists(barcode)
        #---------------------------
        object = $('#document_customer_name')
        items = object.data('source')
        object.typeahead
            source: items,
            updater: (item) ->
                $.ajax '/request_contracts',
                    data:
                        {customer: {name: item}}
                return item

        # Вешаем обработчики на кнопки
        $('.modal-footer > .btn').click ->
            state = $(this).data('state')
            if  state == "close"
                modal.modal('hide')
            else
                $('.modal-body > .simple_form #document_new_state_name').val(state)
                $('.modal-body > .simple_form').submit()

        #---------------------------
    #---------------------------
 
talon_exists = (request_barcode) ->
    talons = []
    $('#operations  .operation').each ->
        barcode = $(this).data('barcode').toString()
        talons.push({'barcode': barcode})
    for talon in talons 
        if talon['barcode'] == request_barcode
            return true
    return false

show_error = (error) ->
    div = $("#form_errors")
    $('#operation_talon_barcode').val('')
    div.html('<div class="alert alert-error">'+error+'</div>')
    show_div div
    return false

show_div = (div) ->
    div.slideDown 300, ->
        interval = setInterval ->
            unless div.css('cursor')=='wait'
                div.slideUp 300
                clearInterval(interval)
        ,2000
remove_parent = (item) ->
    $(item).parent().remove()
#---------------------------
window.show_div = show_div
window.remove_parent = remove_parent