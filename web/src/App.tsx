import React, {createContext, useEffect, useState} from 'react';
import {isEnvBrowser} from './utils/misc';
import {fetchNui} from './utils/fetchNui';
import {DefaultUISetting, ISettingContext, UISetting} from './types';
import stringd from 'stringd';
import {observer} from 'mobx-react-lite';
import {useMainService} from './services/app/main/main.service';
import LiteGraphElement from './components/LiteGraph';
import BluePrintList from './components/BluePrintList';

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
        <div
          /* width={'100vw'}
          height={'100vh'}
          top={0}
          left={0}
          display="flex"
          justifyContent="center"
          alignItems="center"
          className="prose"
          pointerEvents="all"
          backgroundColor="rgba(0, 0, 0, 0.5)" */
          className="h-screen w-screen flex gap-2 p-2 dark"
        >
          <div className="min-w-[200px] h-full bg-zinc-900/90 rounded-xl">
            <BluePrintList />
          </div>
          <div className="  h-full rounded-xl ">
            <LiteGraphElement />
          </div>
        </div>
      )}
    </SettingContext.Provider>
  );
});

export default App;
