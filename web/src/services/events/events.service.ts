import {injectable} from 'inversify';
import {ServicesContainer} from '../../utils/servicesContainer';
import {AppEventListener, IEventMessage} from './type';

@injectable()
export class EventsService {
  eventSubscribers: {[key: string]: Set<AppEventListener>} = {};

  constructor() {
    window.addEventListener('message', this.eventHandler);
  }

  private eventHandler = (e: MessageEvent<IEventMessage>) => {
    const {event, data} = e.data;
    const subscribers = this.eventSubscribers[event];
    if (subscribers) {
      subscribers.forEach(subscriber => subscriber(data));
    }
  };

  subscribe<T>(event: string, listener: AppEventListener<T>) {
    if (!this.eventSubscribers[event]) {
      this.eventSubscribers[event] = new Set();
    }
    this.eventSubscribers[event].add(listener);
    console.log(
      `%c[EventsService] subscribed %c${event} `,
      'color: yellow',
      'font-weight: bold; color: green'
    );
    window.postMessage({event: 'events:subscribed', data: event}, '*');
    return {
      unsubscribe: () => {
        this.unsubscribe(event, listener);
      },
    };
  }

  private unsubscribe(event: string, listener: AppEventListener) {
    if (!this.eventSubscribers[event]) {
      return;
    }
    this.eventSubscribers[event].delete(listener);
  }
}

export const registerEventsService = (container: ServicesContainer) => {
  container.register(EventsService);
};
