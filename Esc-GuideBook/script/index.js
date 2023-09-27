document.addEventListener('DOMContentLoaded', () => {
   
    $(document).ready(function () {
        
        window.addEventListener('message', function (event) {
            const item = event.data;
            if (item.showUI) {
                $(".menu").fadeIn(500);
            }
        });
    
        document.addEventListener('keydown', function (e) {
            if (e.key === 'Escape') {
                $.post('https://Esc-GuideBook/closeUI', JSON.stringify({}));
            }
        });
    });

    $(document).on('keydown', function() {
        switch(event.keyCode) {
            case 27: // ESC
            opened = false
            $(".menu").fadeOut(400);
                $.post("https://Esc-GuideBook/CloseUi", JSON.stringify({}));
                break;
            case 113: // ESC
            opened = false
            $(".menu").fadeOut(400);
            $.post("https://Esc-GuideBook/CloseUi", JSON.stringify({}));
                break;
        }
    });

    Select = function(type) {
        if (type == "exit") {
            $(".menu").fadeOut(400);
            $.post("https://Esc-GuideBook/CloseUi", JSON.stringify({}));
    }};
    
});