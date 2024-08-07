/* eslint-disable @typescript-eslint/no-explicit-any */
import {inject, injectable, multiInject, named, optional} from 'inversify';
import {ScopedLogger} from '../log/scopedLogger';
import {ServicesContainer} from '../../utils/servicesContainer';
import {AppContribution} from './app.extensions';
import {extractMetadata} from '../../utils/extract-metadata';
import {ArrayVar, ObjectVar, Var} from '../../utils/var';
import {EventsService} from '../events/events.service';

@injectable()
class AppService {
  @inject(ScopedLogger)
  @named('AppService')
  protected logService: ScopedLogger;

  @inject(EventsService)
  protected eventsService: EventsService;

  @multiInject(AppContribution)
  @optional()
  protected readonly appContributions: AppContribution[];

  async beforeRender() {
    this.logService.log('Initing');
    this.appContributions.map((contribution: any) => {
      const vars: {
        key: string;
        value: Var<any> | ArrayVar<any> | ObjectVar<any>;
        name: string;
      }[] = extractMetadata('vars', contribution) || [];
      vars.forEach(v => {
        contribution[v.key] = v.value;
        const methods = Object.getOwnPropertyNames(
          Object.getPrototypeOf(v.value)
        );
        const valueInstance: any = v.value;
        methods.forEach(method => {
          this.eventsService.subscribe(
            `${v.name}:${v.key}:${method}`,
            value => {
              valueInstance[method](value);
            }
          );
        });
      });
    });
    await Promise.all(
      this.appContributions.map(contribution => contribution.init?.())
    );

    this.logService.log('Before render');
    await Promise.all(
      this.appContributions.map(contribution => contribution.beforeRender?.())
    );
  }

  async afterRender() {
    this.logService.log('After render');
    await Promise.all(
      this.appContributions.map(contribution => contribution.afterRender?.())
    );
  }
}

export function registerAppService(container: ServicesContainer) {
  container.register(AppService);
}

export function getAppService(container: ServicesContainer): AppService {
  return container.get(AppService);
}
