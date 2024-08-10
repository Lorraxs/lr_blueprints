import {observer} from 'mobx-react-lite';
import React, { useMemo } from 'react';
import {useBluePrintsService} from '../services/blueprints/blueprints.service';
import clsx from 'clsx';
import {FaPlay, FaPause, FaSearch} from 'react-icons/fa';
import { Accordion, Input } from '@mantine/core';
import { useThrottledState } from '@mantine/hooks';

const BluePrintList = observer(() => {
  const [throttledValue, setThrottledValue] = useThrottledState('', 500);
  const BluePrintsService = useBluePrintsService();
  const filteredData = useMemo(() => {
    return BluePrintsService.data.filter((blueprint) =>
      blueprint.name.toLowerCase().includes(throttledValue.toLowerCase()),
    );
  }, [throttledValue, BluePrintsService.data])
  console.log(BluePrintsService.data);
  const serverBlueprints = filteredData.filter(blueprint => blueprint.side === 'server');
  const clientBlueprints = filteredData.filter(blueprint => blueprint.side === 'client');
  const sharedBlueprints = filteredData.filter(blueprint => blueprint.side === 'shared');
  return (
    <div className='flex flex-col gap-2 h-full text-white'>
      <div className='p-2'>
      <Input placeholder="search" leftSection={<FaSearch/>} onChange={(event) => setThrottledValue(event.currentTarget.value)}/>
      </div>
      <div className='h-full overflow-y-auto '>
        <Accordion defaultValue="client" className='!text-white' variant="filled" >
          <Accordion.Item key='client' value={'client'} className='text-white'>
            <Accordion.Control className='text-white'>client</Accordion.Control>
            <Accordion.Panel>{
              clientBlueprints.map((blueprint, index) => (
                <div
                  key={index}
                  className={clsx(
                    'cursor-pointer p-2 rounded-xl border bg-zinc-800 mb-2 flex flex-col text-white',
                    BluePrintsService.selectedBlueprint?.name === blueprint.name &&
                      '!bg-yellow-500/40',
                    blueprint.start ? 'border-green-500' : 'border-yellow-500',
                  )}
                  onClick={() => {
                    BluePrintsService.setSelectBlueprint(blueprint);
                  }}
                >
                  <div className='flex justify-between'>
                    <p className='font-bold text-yellow-500'>{blueprint.side}</p>
                    {blueprint.start ? <FaPlay color='#22c55e' size={20}/> : <FaPause color='#eab308' size={20}/>}
                  </div>
                  <div>{blueprint.name}</div>
                  
                </div>
              ))
            }</Accordion.Panel>
          </Accordion.Item>
        </Accordion>
        <Accordion defaultValue="server" className='!text-white' variant="filled" >
          <Accordion.Item key='server' value={'server'} className='text-white'>
            <Accordion.Control className='text-white'>server</Accordion.Control>
            <Accordion.Panel>{
              serverBlueprints.map((blueprint, index) => (
                <div
                  key={index}
                  className={clsx(
                    'cursor-pointer p-2 rounded-xl border bg-zinc-800 mb-2 flex flex-col text-white',
                    BluePrintsService.selectedBlueprint?.name === blueprint.name &&
                      '!bg-yellow-500/40',
                    blueprint.start ? 'border-green-500' : 'border-yellow-500',
                  )}
                  onClick={() => {
                    BluePrintsService.setSelectBlueprint(blueprint);
                  }}
                >
                  <div className='flex justify-between'>
                    <p className='font-bold text-yellow-500'>{blueprint.side}</p>
                    {blueprint.start ? <FaPlay color='#22c55e' size={20}/> : <FaPause color='#eab308' size={20}/>}
                  </div>
                  <div>{blueprint.name}</div>
                  
                </div>
              ))
            }</Accordion.Panel>
          </Accordion.Item>
        </Accordion>
        <Accordion defaultValue="shared" className='!text-white' variant="filled" >
          <Accordion.Item key='shared' value={'shared'} className='text-white'>
            <Accordion.Control className='text-white'>shared</Accordion.Control>
            <Accordion.Panel>{
              sharedBlueprints.map((blueprint, index) => (
                <div
                  key={index}
                  className={clsx(
                    'cursor-pointer p-2 rounded-xl border bg-zinc-800 mb-2 flex flex-col text-white',
                    BluePrintsService.selectedBlueprint?.name === blueprint.name &&
                      '!bg-yellow-500/40',
                    blueprint.start ? 'border-green-500' : 'border-yellow-500',
                  )}
                  onClick={() => {
                    BluePrintsService.setSelectBlueprint(blueprint);
                  }}
                >
                  <div className='flex justify-between'>
                    <p className='font-bold text-yellow-500'>{blueprint.side}</p>
                    {blueprint.start ? <FaPlay color='#22c55e' size={20}/> : <FaPause color='#eab308' size={20}/>}
                  </div>
                  <div>{blueprint.name}</div>
                  
                </div>
              ))
            }</Accordion.Panel>
          </Accordion.Item>
        </Accordion>
      </div>
      
    </div>
  );
});

export default BluePrintList;
