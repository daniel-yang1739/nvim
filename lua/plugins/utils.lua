return {
  {
    'derektata/lorem.nvim',
    cmd = { "LoremIpsum" },
    config = function()
      require('lorem').opts {
        sentence_length = "medium",
        comma_chance = 0.2,
        max_commas = 2,
      }
    end
  }
}
