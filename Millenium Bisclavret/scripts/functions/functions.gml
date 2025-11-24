function wrap(_val, _min, _max) {
    if (_val > _max) {
        return _min;
    }
    else if ( _val < _min ) {
        return _max;
    }
    else {
        return _val;
    }
}

function chatterbox_update() {
    node = ChatterboxGetContentMetadata(chatterbox);
    text = ChatterboxGetContent(chatterbox, 0);
}

function initaite_battle(_arr) {
    
}