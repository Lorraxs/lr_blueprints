import {inject, injectable, named} from 'inversify';
import {AppContribution, registerAppContribution} from '../app.extensions';
import {ScopedLogger} from '../../log/scopedLogger';
import {
  ServicesContainer,
  defineService,
  useService,
} from '../../../utils/servicesContainer';
import {Var, createVar} from '../../../utils/var';

export type IBoilerPlateService = BoilerPlateService;
export const IBoilerPlateService =
  defineService<IBoilerPlateService>('BoilerPlateService');

export function registerBoilerPlateService(container: ServicesContainer) {
  container.registerImpl(IBoilerPlateService, BoilerPlateService);
  registerAppContribution(container, BoilerPlateService);
}

@injectable()
class BoilerPlateService implements AppContribution {
  @inject(ScopedLogger)
  @named('WebSocketService')
  private logService: ScopedLogger;

  @createVar('BoilerPlateService', new Var('Boilerplate'))
  private var: Var<string>;

  async init() {
    this.logService.log('init');
  }
}

export function useBoilerPlateService(): IBoilerPlateService {
  return useService(IBoilerPlateService);
}
