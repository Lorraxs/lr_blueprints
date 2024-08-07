/* eslint-disable @typescript-eslint/no-explicit-any */
export interface IEventMessage {
  event: string;
  data: any;
}

export type AppEventListener<T = any> = (args: T) => void;
