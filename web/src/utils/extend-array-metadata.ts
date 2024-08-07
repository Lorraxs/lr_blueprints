/* eslint-disable @typescript-eslint/no-explicit-any */
export const extendArrayMetadata = (
  key: string,
  target: any,
  value: any,
  propertyKey?: any
) => {
  const metadata = Reflect.getMetadata(key, target, propertyKey) || [];
  metadata.push(value);
  Reflect.defineMetadata(key, metadata, target, propertyKey);
};
