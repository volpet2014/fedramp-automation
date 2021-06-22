import { createOvermind, createOvermindMock, IConfig } from 'overmind';
import { merge, namespaced } from 'overmind/config';

import type { ValidateSchematronUseCase } from '../../../use-cases/validate-ssp-xml';

import * as actions from './actions';
import * as report from './report';

type UseCases = {
  validateSchematron: ValidateSchematronUseCase;
};

export const getPresenterConfig = (useCases: UseCases) => {
  return merge(
    {
      state: {
        baseUrl: '/',
        repositoryUrl: '#',
      },
      actions,
      effects: {
        useCases,
      },
    },
    namespaced({
      report: report.getPresenterConfig(),
    }),
  );
};
export type PresenterConfig = ReturnType<typeof getPresenterConfig>;
declare module 'overmind' {
  interface Config extends IConfig<PresenterConfig> {}
}

export type PresenterContext = {
  baseUrl: string;
  debug: boolean;
  repositoryUrl: string;
  useCases: UseCases;
};

export const createPresenter = (ctx: PresenterContext) => {
  const presenter = createOvermind(getPresenterConfig(ctx.useCases), {
    devtools: ctx.debug,
  });
  presenter.actions.setBaseUrl(ctx.baseUrl);
  presenter.actions.setRepositoryUrl(ctx.repositoryUrl);
  return presenter;
};
export type Presenter = ReturnType<typeof createPresenter>;

/**
 * `createOvermindMock` expects actual effect functions. They may be shimmed in
 * with the return value from this function.
 * These use cases will never be called, because Overmind requires mock effects
 * specified as the second parameter of `createOvermindMock`.
 * @returns Stubbed use cases
 */
const getUseCasesShim = (): UseCases => {
  const stub = jest.fn();
  return {
    validateSchematron: stub,
  };
};

export const createPresenterMock = (useCaseMocks?: Partial<UseCases>) => {
  const presenter = createOvermindMock(getPresenterConfig(getUseCasesShim()), {
    useCases: useCaseMocks,
  });
  return presenter;
};
export type PresenterMock = ReturnType<typeof createPresenterMock>;