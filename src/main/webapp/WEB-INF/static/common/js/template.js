template.helper('dateFormat', function (date, format) {
    return new Date(date.time).format(format);
});