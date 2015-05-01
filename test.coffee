should = require('should')
lib = require('./index')

module.exports =
    'util function':
        '#work day':
            '2015-4-21 should be a work day': ->
                date = new Date('2015-4-21')
                lib.isWorkDay(date).should.be.ok
            '2015-2-28 is saturday but should work too': ->
                lib.isWorkDay(new Date('2015-2-28')).should.be.ok
        '#legal holiday':
            '2015-4-5 should be a legal holiday': ->
                lib.isLegalHoliday(new Date('2015-4-5')).should.be.ok
            '2015-5-1 should be a legal holiday': ->
                lib.isLegalHoliday(new Date('2015-5-1')).should.be.ok
