local permutation = require('hop.permutation')
local eq = assert.are.same

describe('permutation:', function()
    it('keys = abc', function()
        local keys = 'abc'
        local num = 128
        local res = permutation.permute(keys, num)
        eq(#res, num)
        eq(res[1], 'aaaa')
        eq(res[num], 'cabab')
    end)

    it('keys = asdghklqwertyuiopzxcvbnmfj', function()
        local keys = 'asdghklqwertyuiopzxcvbnmfj'
        local z = #keys

        local num = z - 1
        local res = permutation.permute(keys, num)
        eq(#res, num)
        eq(res[1], 'a')
        eq(res[num], 'f')

        num = z
        res = permutation.permute(keys, num)
        eq(#res, num)
        eq(res[1], 'a')
        eq(res[num], 'j')

        num = z + 1
        res = permutation.permute(keys, num)
        eq(#res, num)
        eq(res[1], 'a')
        eq(res[num - 1], 'ja')
        eq(res[num], 'js')

        num = z + z
        res = permutation.permute(keys, num)
        eq(#res, num)
        eq(res[1], 'a')
        eq(res[z - 1], 'ja')
        eq(res[z], 'js')
        eq(res[num - 1], 'fa')
        eq(res[num], 'fs')

        num = z * z - 1
        res = permutation.permute(keys, num)
        eq(#res, num)
        eq(res[1], 'ja')
        eq(res[num], 'af')

        num = z * z
        res = permutation.permute(keys, num)
        eq(#res, num)
        eq(res[1], 'ja')
        eq(res[num], 'aj')

        num = z * z + 1
        res = permutation.permute(keys, num)
        eq(#res, num)
        eq(res[1], 'aa')
        eq(res[num - 1], 'jja')
        eq(res[num], 'jjs')
    end)
end)
