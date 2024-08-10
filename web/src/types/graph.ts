/* eslint-disable @typescript-eslint/no-explicit-any */
import {INodeInputSlot, widgetTypes} from 'lr-litegraph';

export type NodePropertieType =
  | 'number'
  | 'string'
  | 'boolean'
  | 'object'
  | 'vec3';

export type NodeData = {
  name: string;
  title?: string;
  inputs: {
    name: string;
    type: NodePropertieType;
    extra_info?: Partial<INodeInputSlot>;
  }[];
  outputs: {
    name: string;
    type: NodePropertieType;
    extra_info?: Partial<INodeInputSlot>;
  }[];
  properties?: {
    name: string;
    type: NodePropertieType;
    default_value?: any;
    extra_info?: Partial<INodeInputSlot>;
  }[];
  widgets?: {
    type: widgetTypes;
    name: string;
    value: any;
    extra_info?: any;
  }[],
  widgets_info?: Record<string, any>;
  desc?: string;
};

export interface IBlueprint {name: string; data: any; start: boolean; side: "client" | "server" | "shared"}