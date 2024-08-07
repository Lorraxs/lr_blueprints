import {describe, it} from 'vitest';
import fs from 'fs';
import start from '../main';

describe('App', () => {
  it('renders the App component', () => {
    document.body.innerHTML = "<div id='root'></div>";
    const writer = fs.createWriteStream('../types/nui.type.lua', {
      flags: 'w',
    });
    writer.write('---@alias INuiEvents ');
    const events: string[] = [];
    const subcribeEventHandlers = (e: MessageEvent) => {
      events.push(`"${e.data.data}"`);
    };
    window.addEventListener('message', subcribeEventHandlers);
    start(async () => {
      window.removeEventListener('message', subcribeEventHandlers);
      writer.write(events.join('|'));
      writer.write('\n');
      writer.write('\n');
      writer.write(`---@param event INuiEvents
---@param data any
function NuiDispatch(event, data)
  SendNUIMessage({ type = event, data = data })
end
`);
      writer.close();
    });
  });
});
