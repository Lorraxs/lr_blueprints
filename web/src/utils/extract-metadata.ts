/* eslint-disable @typescript-eslint/no-explicit-any */
export const extractMetadata = (key: string, target: any) => {
  const metadata = Reflect.getMetadata(key, target);
  Reflect.deleteMetadata(key, target);
  return metadata;
};
