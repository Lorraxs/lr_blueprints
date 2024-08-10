import {inject, injectable, named} from 'inversify';
import {AppContribution, registerAppContribution} from '../app.extensions';
import {ScopedLogger} from '../../log/scopedLogger';
import {
  ServicesContainer,
  defineService,
  useService,
} from '../../../utils/servicesContainer';
import {EventsService} from '../../events/events.service';
import {makeAutoObservable} from 'mobx';
import {isEnvBrowser} from '../../../utils/misc';
import { IBluePrintsService } from '../../blueprints/blueprints.service';

export type IMainService = MainService;
export const IMainService = defineService<IMainService>('MainService');

export function registerMainService(container: ServicesContainer) {
  container.registerImpl(IMainService, MainService);
  registerAppContribution(container, MainService);
}

@injectable()
class MainService implements AppContribution {
  @inject(ScopedLogger)
  @named('MainService')
  private logService: ScopedLogger;
  @inject(EventsService)
  private eventsService: EventsService;
  @inject(IBluePrintsService)
  private bluePrintsService: IBluePrintsService;

  show = isEnvBrowser() ? true : false;

  async init() {
    this.logService.log('init');
    this.eventsService.subscribe('main:setShow', (show: boolean) => {
      if (show) {
        this.bluePrintsService.loadData();
        this.show = true;
      }else{
        this.show = false;
        this.bluePrintsService.setSelectBlueprint(null);
      }
    });
  }

  setShow(show: boolean) {
    this.show = show;
  }

  constructor() {
    makeAutoObservable(this);
  }
}

export function useMainService(): IMainService {
  return useService(IMainService);
}
