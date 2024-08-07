/* eslint-disable @typescript-eslint/no-explicit-any */
import {injectable} from 'inversify';
import {LogProvider} from '../logService.extensions';

@injectable()
export class ConsoleLogProvider implements LogProvider {
  log(...args: any[]) {
    console.log(...args);
  }

  error(error: Error, extra: Record<string, any> | undefined) {
    console.error(error, extra);
  }
}
