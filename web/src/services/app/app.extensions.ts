import {interfaces} from 'inversify';
import {ServicesContainer} from '../../utils/servicesContainer';

export const AppContribution = Symbol('AppContribution');
export interface AppContribution {
  init?(): Promise<void>;

  beforeRender?(): Promise<void>;

  afterRender?(): Promise<void>;
}

export function registerAppContribution<T extends AppContribution>(
  container: ServicesContainer,
  service: interfaces.Newable<T>
) {
  container.registerImpl(AppContribution, service);
}
