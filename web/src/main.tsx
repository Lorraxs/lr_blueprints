import 'reflect-metadata';
import React from 'react';
import App from './App';
import './index.scss';
import {NextUIProvider} from '@nextui-org/react';
import 'react-toastify/dist/ReactToastify.css';
import {startBrowserApp} from './utils/createApp';
import {registerLogService} from './services/log/logService';
import {ConsoleLogProvider} from './services/log/providers/consoleLogProvider';
import {registerMainService} from './services/app/main/main.service';
import {registerEventsService} from './services/events/events.service';
import {registerBoilerPlateService} from './services/app/boilerplate/boilerplate.service';
import {ServicesContainer} from './utils/servicesContainer';

const start = (
  afterRender?: (container: ServicesContainer) => void | Promise<void>
) => {
  startBrowserApp({
    defineServices: cotainer => {
      // Define services here
      registerLogService(cotainer, [ConsoleLogProvider]);
      registerEventsService(cotainer);
      registerMainService(cotainer);
      registerBoilerPlateService(cotainer);
    },
    beforeRender: async () => {},
    render: () => (
      <NextUIProvider>
        <App />
      </NextUIProvider>
    ),
    afterRender(container) {
      afterRender && afterRender(container);
    },
  });
};

start();

export default start;
