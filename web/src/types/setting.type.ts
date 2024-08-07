export interface ISettingContext {
  setting: UISetting;
  setSetting: (setting: UISetting) => void;
  L: (key: string) => string;
}

export interface UISetting {
  locale: {[key: string]: string};
}
export const DefaultUISetting: ISettingContext = {
  setting: {
    locale: {},
  },
  setSetting: () => {},
  L: (key: string) => key,
};
