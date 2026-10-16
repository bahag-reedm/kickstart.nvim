return {
  'pwntester/octo.nvim',
  cmd = 'Octo',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope.nvim',
    'nvim-tree/nvim-web-devicons',
  },
  opts = { picker = 'telescope' },
  config = function(_, opts)
    require('octo').setup(opts)
    vim.api.nvim_create_autocmd('LspAttach', {
      callback = function(ev)
        if vim.startswith(vim.uri_from_bufnr(ev.buf), 'octo://') then
          vim.schedule(function() vim.lsp.buf_detach_client(ev.buf, ev.data.client_id) end)
        end
      end,
    })
  end,
  keys = {
    { '<leader>op', '<cmd>Octo pr list<cr>', desc = '[O]cto [P]R list' },
  },
}
