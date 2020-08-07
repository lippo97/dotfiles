'use strict';

function onBufWrite() {
  console.log('Buffer written!');
}

module.exports = (plugin) => {
  async function setLine() {
    const buffer = await plugin.nvim.buffer;
    const lines = await buffer.getLines({
      start: 0,
      end: 1,
    });
    plugin.nvim.setLine(lines + "ciao");
    //plugin.nvim.setLine('A line, for your troubles');
  }
  plugin.registerCommand('SetMyLine', [plugin.nvim.buffer, setLine]);
  plugin.registerAutocmd('BufWritePre', onBufWrite, { pattern: '*' });
};
