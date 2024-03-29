local present, packer = pcall(require, 'packer')

if not present then
    local packer_path = vim.fn.stdpath('data') ..
                            '/site/pack/packer/start/packer.nvim'

    print('Cloning packer..')
    -- remove the dir before cloning
    vim.fn.delete(packer_path, 'rf')
    vim.fn.system({
        'git',
        'clone',
        'https://github.com/wbthomason/packer.nvim',
        '--depth',
        '20',
        packer_path
    })

    present, packer = pcall(require, 'packer')

    if present then
        print('Packer cloned successfully.')
    else
        error('Couldn\'t clone packer !\nPacker path: ' .. packer_path)
    end
end

return packer.init { display = { open_fn = require('packer.util').float } }
