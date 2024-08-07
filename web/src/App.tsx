import React, {createContext, useEffect, useState} from 'react';
import {Box} from 'lr-components';
import {isEnvBrowser} from './utils/misc';
import {fetchNui} from './utils/fetchNui';
import {DefaultUISetting, ISettingContext, UISetting} from './types';
import stringd from 'stringd';
import {observer} from 'mobx-react-lite';
import {useMainService} from './services/app/main/main.service';

export const SettingContext = createContext<ISettingContext>(DefaultUISetting);

const App = observer(() => {
  const mainService = useMainService();
  const [setting, setSetting] = useState<UISetting>({locale: {}});
  const L = (key: string, args?: {[key: string]: string | number}) => {
    if (setting.locale[key]) {
      return stringd(setting.locale[key], args) as string;
    }
    return key;
  };
  useEffect(() => {
    if (!isEnvBrowser()) {
      setTimeout(async () => {
        const UISetting = await fetchNui<UISetting>('AppReady');
        setSetting(UISetting);
      }, 2000);
      const keyHandler = (e: KeyboardEvent) => {
        if (e.key === 'Escape') {
          fetchNui('close');
        }
      };
      window.addEventListener('keydown', keyHandler);
      return () => {
        window.removeEventListener('keydown', keyHandler);
      };
    }
  }, [setSetting]);
  return (
    <SettingContext.Provider value={{setting, setSetting, L}}>
      {mainService.show && (
        <Box
          width={'100vw'}
          height={'100vh'}
          top={0}
          left={0}
          display="flex"
          justifyContent="center"
          alignItems="center"
          className="prose"
          pointerEvents="none"
        >
          APPS
        </Box>
      )}
    </SettingContext.Provider>
  );
});

export default App;
