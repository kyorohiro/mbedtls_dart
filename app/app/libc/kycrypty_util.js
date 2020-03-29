
kycrypty_get_buffer = function(index, len) {
    return new Uint8Array(Module.HEAP8.buffer, index, len);
}
