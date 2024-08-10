export * from './setting.type';

export type IStatusError = {
  status: 'ERROR';
  message: string;
};

export type IStatusSuccess<T> = {
  status: 'SUCCESS';
  message?: string;
  data: T;
};

export type IStatus<T> = IStatusError | IStatusSuccess<T>;
