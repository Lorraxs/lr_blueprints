import {inject, injectable, named} from 'inversify';
import {
  defineService,
  ServicesContainer,
  useService,
} from '../../utils/servicesContainer';
import {AppContribution, registerAppContribution} from '../app/app.extensions';
import {ScopedLogger} from '../log/scopedLogger';
import {makeAutoObservable} from 'mobx';
import {isEnvBrowser} from '../../utils/misc';
import {fetchNui} from '../../utils/fetchNui';

import {LiteGraph} from 'lr-litegraph';
import {IBlueprint, NodeData} from '../../types/graph';
import {IStatus} from '../../types';

// eslint-disable-next-line @typescript-eslint/no-explicit-any
/* (LiteGraph as any).use_uuids = true; */

export type IBluePrintsService = BluePrintsService;
export const IBluePrintsService =
  defineService<IBluePrintsService>('BluePrintsService');

export function registerBluePrintsService(container: ServicesContainer) {
  container.registerImpl(IBluePrintsService, BluePrintsService);
  registerAppContribution(container, BluePrintsService);
}

@injectable()
class BluePrintsService implements AppContribution {
  @inject(ScopedLogger)
  @named('BluePrintsService')
  private logService: ScopedLogger;

  data: IBlueprint[] = [];
  selectedBlueprint: IBlueprint | null = null;

  setSelectBlueprint(blueprint: IBlueprint | null) {
    this.selectedBlueprint = blueprint;
  }

  async init() {
    this.logService.log('init');
    this.loadData();

    if (isEnvBrowser()) {
      this.loadNodes([
        {
          name: 'fivem/test',
          inputs: [],
          outputs: [{name: 'position', type: 'vec3'}],
          properties: [{name: 'position', type: 'vec3', default_value: [0, 0, 0]}],
        },
      ]);
    }else{
      const nodes = await fetchNui<NodeData[]>('loadNodes');
      console.log('loadNodes', nodes);
      this.loadNodes(nodes);
    }
  }
  async start() {
    this.logService.log('start');
  }

  async loadData() {
    if (isEnvBrowser()) {
      this.data = [
        {
          name: 'test asd sadasd s dsdasdsad',
          data:{"last_node_id":2,"last_link_id":1,"nodes":[{"id":2,"type":"basic/watch","pos":[762,148],"size":{"0":140,"1":26},"flags":{},"order":1,"mode":0,"inputs":[{"name":"value","type":0,"link":1,"label":"1.000"}],"properties":{}},{"id":1,"type":"basic/const","pos":[459,111],"size":[180,30],"flags":{},"order":0,"mode":0,"outputs":[{"name":"value","type":"number","links":[1],"label":"1.000","slot_index":0}],"properties":{"value":1}}],"links":[[1,1,0,2,0,"number"]],"groups":[],"config":{},"extra":{},"version":0.4},
          start: false,
          side: 'client',
        },
        {
          name: 'casdsad',
          data:{"last_node_id":2,"last_link_id":1,"nodes":[{"id":2,"type":"basic/watch","pos":[762,148],"size":{"0":140,"1":26},"flags":{},"order":1,"mode":0,"inputs":[{"name":"value","type":0,"link":1,"label":"1.000"}],"properties":{}},{"id":1,"type":"basic/const","pos":[459,111],"size":[180,30],"flags":{},"order":0,"mode":0,"outputs":[{"name":"value","type":"number","links":[1],"label":"1.000","slot_index":0}],"properties":{"value":1}}],"links":[[1,1,0,2,0,"number"]],"groups":[],"config":{},"extra":{},"version":0.4},
          start: false,
          side: 'shared',
        },
        {
          name: 'vfdg',
          data:{"last_node_id":2,"last_link_id":1,"nodes":[{"id":2,"type":"basic/watch","pos":[762,148],"size":{"0":140,"1":26},"flags":{},"order":1,"mode":0,"inputs":[{"name":"value","type":0,"link":1,"label":"1.000"}],"properties":{}},{"id":1,"type":"basic/const","pos":[459,111],"size":[180,30],"flags":{},"order":0,"mode":0,"outputs":[{"name":"value","type":"number","links":[1],"label":"1.000","slot_index":0}],"properties":{"value":1}}],"links":[[1,1,0,2,0,"number"]],"groups":[],"config":{},"extra":{},"version":0.4},
          start: false,
          side: 'server',
        },
      ];
      
      return;
    }
    const data = await fetchNui<IBlueprint[]>('loadData');
    this.data = data;
    this.guardBlueprints()
    
  }

  guardBlueprints() {
    this.data.forEach(blueprint => {
      const {nodes} = blueprint.data
      nodes?.forEach((node: { inputs: any; outputs: any; })=>{
        const {inputs, outputs} = node;
        inputs?.forEach((input: { link: null | undefined; }) => {
          if (input.link === undefined) {
            input.link = null;
          }
        });
        outputs?.forEach((output: { links: null | undefined; }) => {
          if (output.links === undefined) {
            output.links = null;
          }
        });
      })
    });
  }

  loadNodes(nodes: NodeData[]) {
    nodes.forEach(node => {
      const {name, inputs, outputs, properties, widgets, title, desc,widgets_info} = node;
      const nodeFunc = function () {
        inputs?.forEach(input => {
          // eslint-disable-next-line @typescript-eslint/no-explicit-any
          (this as any).addInput(input.name, input.type, input.extra_info);
        });
        outputs?.forEach(input => {
          // eslint-disable-next-line @typescript-eslint/no-explicit-any
          (this as any).addOutput(input.name, input.type, input.extra_info);
        });
        properties?.forEach(prop => {
          console.log('addProperty', prop);
          this.addProperty(prop.name, prop.default_value, prop.type, prop.extra_info);
        });
        widgets?.forEach(widget => {
          this.addWidget(widget.type, widget.name, widget.value, widget.extra_info);
        })
      };
      Object.defineProperty(nodeFunc, 'name', {value: title || name});
      if(desc){
        Object.defineProperty(nodeFunc, 'desc', {value: desc});
      }
      if (widgets_info) {
        Object.defineProperty(nodeFunc, 'widgets_info', {value: widgets_info});
      }
      // eslint-disable-next-line @typescript-eslint/no-explicit-any
      LiteGraph.registerNodeType(name, nodeFunc as any);
    });
  }

  async addBlueprint(name: string, side: "client" | "server" | "shared") {
    if (isEnvBrowser()) {
      this.data.push({name, data: {}, start: false, side});
      this.selectedBlueprint = this.data[this.data.length - 1];
      return;
    }
    const result = await fetchNui<IStatus<IBlueprint>>('addBlueprint', {name, side});
    if (result.status === 'SUCCESS') {
      this.data = [...this.data, result.data];
    }
  }

  async test(data: object) {
    if (!this.selectedBlueprint) return;
    if (isEnvBrowser()) {
      console.log('test', this.selectedBlueprint.name, data);
      return data;
    }
    console.log('test', this.selectedBlueprint.name, data);
    return fetchNui('test', {
      name: this.selectedBlueprint.name,
      data,
    });
  }

  async save(data: object) {
    if (!this.selectedBlueprint) return;
    if (isEnvBrowser()) {
      console.log(data)
      this.selectedBlueprint.data = data;
      return;
    }
    const response = await  fetchNui<IStatus<IBlueprint>>('save', {
      name: this.selectedBlueprint.name,
      data,
    });
    if(response.status === 'SUCCESS'){
      this.data = this.data.map(blueprint => {
        if (blueprint.name === this.selectedBlueprint?.name) {
          blueprint.data = response.data.data;
        }
        return blueprint;
      })
      this.selectedBlueprint = {...this.selectedBlueprint,data: response.data.data};
    }
  }

  async delete(){
    if (!this.selectedBlueprint) return;
    if (isEnvBrowser()) {
      const index = this.data.findIndex(blueprint => blueprint.name === this.selectedBlueprint?.name);
      if (index !== -1) {
        this.data.splice(index, 1);
        this.selectedBlueprint = null;
      }
      return;
    }
    const result = await fetchNui<IStatus<any>>('delete', this.selectedBlueprint.name);
    if (result.status === 'SUCCESS') {
      this.data = this.data.filter(blueprint => blueprint.name !== this.selectedBlueprint?.name);
      this.selectedBlueprint = null;
      this.loadData();
    }
  }

  async toggle(){
    if (!this.selectedBlueprint) return;
    if (isEnvBrowser()) {
      this.data = this.data.map(blueprint => {
        if (blueprint.name === this.selectedBlueprint?.name) {
          blueprint.start = !blueprint.start;
        }
        return blueprint;
      })
      this.selectedBlueprint = this.data.find(blueprint => blueprint.name === this.selectedBlueprint?.name) || null;
      return;
    }
    const result = await fetchNui<IStatus<boolean>>('toggle', this.selectedBlueprint.name);
    if (result.status === 'SUCCESS') {
      this.data = this.data.map(blueprint => {
        if (blueprint.name === this.selectedBlueprint?.name) {
          blueprint.start = result.data;
        }
        return blueprint;
      })
      this.selectedBlueprint = this.data.find(blueprint => blueprint.name === this.selectedBlueprint?.name) || null
    }
  }

  constructor() {
    makeAutoObservable(this);
  }
}

export function useBluePrintsService(): IBluePrintsService {
  return useService(IBluePrintsService);
}
