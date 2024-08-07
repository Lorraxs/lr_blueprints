/* eslint-disable @typescript-eslint/no-explicit-any */
import {makeAutoObservable} from 'mobx';
import {injectable} from 'inversify';
import {extendArrayMetadata} from './extend-array-metadata';

@injectable()
export class Var<T> {
  value: T | null = null;
  constructor(value: T) {
    makeAutoObservable(this);
    this.value = value;
  }
  setValue(value: T | null) {
    this.value = value;
  }
  getValue() {
    return this.value;
  }
}

@injectable()
export class ArrayVar<T extends {id: number | string}> {
  value: T[];
  constructor(value: T[] | null) {
    makeAutoObservable(this);
    this.value = value || [];
  }
  setValue(value: T[]) {
    this.value = value;
  }
  getValue() {
    return this.value;
  }

  push(value: T) {
    this.value.push(value);
  }
  pop() {
    return this.value.pop();
  }
  shift() {
    return this.value.shift();
  }
  unshift(value: T) {
    this.value.unshift(value);
  }
  splice(start: number, deleteCount: number, ...items: T[]) {
    this.value.splice(start, deleteCount, ...items);
  }
  clear() {
    this.value = [];
  }
  remove(index: number) {
    return this.value.splice(index, 1);
  }
  removeById(id: number | string) {
    const index = this.value.findIndex(item => item.id === id);
    if (index !== -1) {
      return this.value.splice(index, 1);
    }
  }
  update({id, value}: {id: number | string; value: Partial<T>}) {
    const index = this.value.findIndex(item => item.id === id);
    if (index !== -1) {
      const match = this.value[index];
      Object.assign(match, value);
      this.value[index] = match;
      this.value = [...this.value];
      return true;
    }
    return false;
  }
  sort(compareFn?: (a: T, b: T) => number) {
    return this.value.slice().sort(compareFn);
  }
}

@injectable()
export class ObjectVar<T extends {[key: string]: any}> {
  value: T | null = null;
  constructor(value: T | null) {
    makeAutoObservable(this);
    this.value = value;
  }
  setValue(value: T) {
    this.value = value;
  }
  getValue() {
    return this.value;
  }
  set(key: string, value: any) {
    if (!this.value) {
      this.value = {} as T;
    }
    this.value = {...this.value, [key]: value};
  }
  get(key: string) {
    if (!this.value) {
      return null;
    }
    return this.value[key];
  }
  remove(key: string) {
    if (!this.value) {
      return;
    }
    delete this.value[key];
  }
  clear() {
    this.value = {} as T;
  }
}

export function createVar<T>(
  serviceName: string,
  instance:
    | ArrayVar<T & {id: string | number}>
    | Var<T>
    | ObjectVar<T & {[key: string]: any}>
): PropertyDecorator {
  return (target: any, propertyKey: string | symbol) => {
    extendArrayMetadata('vars', target, {
      key: propertyKey,
      name: serviceName,
      value: instance,
    });
  };
}
