import {expect, test} from 'vitest';
import {returnTrue} from '../utils/functional';

test('returnTrue', () => {
  expect(returnTrue()).toBe(true);
});
