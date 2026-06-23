local stub = require('luassert.stub')

describe('config', function()
    local notify_once = stub(vim, 'notify_once')
    local notify = stub(vim, 'notify')
    local config = require('git-worktree.config')

    it('returns the default config', function()
        assert.truthy(config.change_directory_command)
    end)

    it('can have configuration applied', function()
        config.change_directory_command = 'test'
        assert.equals(config.change_directory_command, 'test')
    end)

    it('No notifications at startup.', function()
        assert.stub(notify_once).was_not_called()
        assert.stub(notify).was_not_called()
    end)
end)
