// Loadout — root app
// Wires state, navigation, sheets, tweaks panel.

const TWEAK_DEFAULTS = /*EDITMODE-BEGIN*/{
  "dark": false,
  "accent": "blue",
  "statsView": "radar",
  "showSecondPhone": false
}/*EDITMODE-END*/;

function App() {
  const [t, setTweak] = useTweaks(TWEAK_DEFAULTS);
  const theme = t.dark ? 'dark' : 'light';
  const accent = ACCENTS[t.accent || 'blue'][theme];

  React.useEffect(() => {
    document.body.classList.toggle('dark', !!t.dark);
  }, [t.dark]);

  // App state
  const [tab, setTab] = React.useState('build');
  const [savedBuilds, setSavedBuilds] = React.useState(LD.savedBuilds);
  const [build, setBuild] = React.useState(LD.activeBuild);
  const [openItemId, setOpenItemId] = React.useState(null);
  const [pickerKind, setPickerKind] = React.useState(null);
  const [jewelEdit, setJewelEdit] = React.useState(null); // { itemId, slotIdx, slotLevel }
  const [equipCategory, setEquipCategory] = React.useState('weapons');

  const dispatch = React.useCallback((action) => {
    if (action.type === 'tab') setTab(action.tab);
    else if (action.type === 'openItem') setOpenItemId(action.id);
    else if (action.type === 'pickSlot') {
      setPickerKind(action.kind);
    }
    else if (action.type === 'loadBuild') {
      const b = savedBuilds.find(x => x.id === action.id);
      if (b) setBuild(b);
    }
    else if (action.type === 'newBuild') {
      const fresh = {
        id: 'b-new-' + Date.now(),
        name: 'New Build',
        note: 'Untitled',
        slots: { weapon: null, head: null, chest: null, arms: null, waist: null, legs: null, charm: null },
        decorations: {},
      };
      setSavedBuilds(list => [...list, fresh]);
      setBuild(fresh);
      setTab('build');
    }
    else if (action.type === 'renameBuild') {
      setSavedBuilds(list => list.map(b =>
        b.id === action.id ? { ...b, name: action.name } : b
      ));
      setBuild(b => b.id === action.id ? { ...b, name: action.name } : b);
    }
    else if (action.type === 'deleteBuild') {
      const next = savedBuilds.filter(b => b.id !== action.id);
      if (build.id === action.id) {
        if (next.length) {
          setBuild(next[0]);
          setSavedBuilds(next);
        } else {
          // Empty state: make a fresh untitled build
          const fresh = {
            id: 'b-new-' + Date.now(),
            name: 'New Build',
            note: 'Untitled',
            slots: { weapon: null, head: null, chest: null, arms: null, waist: null, legs: null, charm: null },
            decorations: {},
          };
          setBuild(fresh);
          setSavedBuilds([fresh]);
        }
      } else {
        setSavedBuilds(next);
      }
    }
    else if (action.type === 'statsView') setTweak('statsView', action.value);
    else if (action.type === 'compare') {
      // soft-stub: focus the panel, would open a compare flow
      alert('Compare mode (placeholder) — pick two builds to compare side-by-side.');
    }
    else if (action.type === 'editBuildName') {
      const next = window.prompt('Build name', build.name);
      if (next) setBuild({ ...build, name: next });
    }
    else if (action.type === 'equip') {
      const it = LD.byId[action.id];
      if (!it) return;
      setBuild(b => ({ ...b, slots: { ...b.slots, [it.kind]: it.id } }));
      setOpenItemId(null);
      setPickerKind(null);
    }
    else if (action.type === 'change') {
      // Open Equipment tab with the right category for the item we want to swap
      const it = LD.byId[action.id];
      if (!it) return;
      const cat = it.kind === 'weapon' ? 'weapons'
                : it.kind === 'charm'  ? 'charm'
                : 'armor';
      setEquipCategory(cat);
      setOpenItemId(null);
      setTab('equipment');
    }
    else if (action.type === 'pickJewel') {
      setJewelEdit({ itemId: action.itemId, slotIdx: action.slotIdx, slotLevel: action.slotLevel });
    }
    else if (action.type === 'setJewel') {
      const key = `${action.itemId}-${action.slotIdx}`;
      setBuild(b => ({ ...b, decorations: { ...b.decorations, [key]: action.jewelId } }));
      setJewelEdit(null);
    }
    else if (action.type === 'clearJewel') {
      const key = `${action.itemId}-${action.slotIdx}`;
      setBuild(b => {
        const next = { ...b.decorations };
        delete next[key];
        return { ...b, decorations: next };
      });
      setJewelEdit(null);
    }
  }, [build, savedBuilds, setTweak]);

  // ────────────────────────────────────────────────────────────
  // Screens
  // ────────────────────────────────────────────────────────────
  const screen = () => {
    if (tab === 'build')     return <BuildScreen     theme={theme} accent={accent} build={build} dispatch={dispatch} />;
    if (tab === 'equipment') return <EquipmentScreen theme={theme} accent={accent} build={build} dispatch={dispatch}
                                       initialCategory={equipCategory} />;
    if (tab === 'stats')     return <StatsScreen     theme={theme} accent={accent} build={build}
                                       statsView={t.statsView} dispatch={dispatch} />;
    if (tab === 'saved')     return <SavedScreen     theme={theme} accent={accent} build={build} savedBuilds={savedBuilds} dispatch={dispatch} />;
    return null;
  };

  const openItem = openItemId ? LD.byId[openItemId] : null;

  // ────────────────────────────────────────────────────────────
  // Phone shell
  // ────────────────────────────────────────────────────────────
  const phone = (
    <div data-screen-label={`Loadout · ${tab[0].toUpperCase() + tab.slice(1)}`}
         style={{ position: 'relative' }}>
      <IOSDevice dark={t.dark}>
        <div style={{ position: 'absolute', inset: 0 }}>
          {screen()}
          <TabBar tab={tab} onChange={setTab} theme={theme} accent={accent} />

          {/* Item detail sheet */}
          <Sheet open={!!openItem} onClose={() => setOpenItemId(null)} theme={theme} height="86%">
            {openItem && (
              <EquipmentDetail
                item={openItem} theme={theme} accent={accent} build={build}
                onClose={() => setOpenItemId(null)}
                onEquip={() => dispatch({ type: 'equip', id: openItem.id })}
                onChange={() => dispatch({ type: 'change', id: openItem.id })}
                onPickJewel={(slotIdx, slotLevel) => dispatch({
                  type: 'pickJewel', itemId: openItem.id, slotIdx, slotLevel,
                })}
              />
            )}
          </Sheet>

          {/* Slot picker sheet */}
          <Sheet open={!!pickerKind} onClose={() => setPickerKind(null)} theme={theme} height="84%">
            {pickerKind && (
              <SlotPicker
                kind={pickerKind} theme={theme} accent={accent} build={build}
                onClose={() => setPickerKind(null)}
                onPick={(id) => dispatch({ type: 'equip', id })}
              />
            )}
          </Sheet>

          {/* Jewel picker sheet */}
          <Sheet open={!!jewelEdit} onClose={() => setJewelEdit(null)} theme={theme} height="86%">
            {jewelEdit && (
              <JewelPicker
                itemId={jewelEdit.itemId}
                slotIdx={jewelEdit.slotIdx}
                slotLevel={jewelEdit.slotLevel}
                build={build} theme={theme} accent={accent}
                onClose={() => setJewelEdit(null)}
                onPick={(jewelId) => dispatch({ type: 'setJewel', itemId: jewelEdit.itemId, slotIdx: jewelEdit.slotIdx, jewelId })}
                onClear={() => dispatch({ type: 'clearJewel', itemId: jewelEdit.itemId, slotIdx: jewelEdit.slotIdx })}
              />
            )}
          </Sheet>
        </div>
      </IOSDevice>
    </div>
  );

  // ────────────────────────────────────────────────────────────
  // Tweaks panel
  // ────────────────────────────────────────────────────────────
  const tweaks = (
    <TweaksPanel title="Tweaks">
      <TweakSection label="Theme" />
      <TweakToggle label="Dark mode" value={t.dark}
        onChange={(v) => setTweak('dark', v)} />
      <TweakRadio label="Accent" value={t.accent || 'blue'}
        options={['blue', 'orange', 'green', 'purple', 'graphite']}
        onChange={(v) => setTweak('accent', v)} />
      <TweakSection label="Display" />
      <TweakRadio label="Resistances" value={t.statsView || 'radar'}
        options={['radar', 'bars']}
        onChange={(v) => setTweak('statsView', v)} />
      <TweakToggle label="Side-by-side compare" value={t.showSecondPhone}
        onChange={(v) => setTweak('showSecondPhone', v)} />
    </TweaksPanel>
  );

  // Side-by-side: light + dark
  if (t.showSecondPhone) {
    return (
      <div style={{
        display: 'flex', gap: 36, alignItems: 'center', justifyContent: 'center',
        flexWrap: 'wrap',
      }}>
        {phone}
        <div style={{ position: 'relative' }}>
          <IOSDevice dark={!t.dark}>
            <div style={{ position: 'absolute', inset: 0 }}>
              <CompareScreen theme={!t.dark ? 'dark' : 'light'}
                accent={ACCENTS[t.accent || 'blue'][!t.dark ? 'dark' : 'light']}
                build={build} statsView={t.statsView} />
              <TabBar tab={tab} onChange={() => {}}
                theme={!t.dark ? 'dark' : 'light'}
                accent={ACCENTS[t.accent || 'blue'][!t.dark ? 'dark' : 'light']} />
            </div>
          </IOSDevice>
        </div>
        {tweaks}
      </div>
    );
  }

  return (
    <>
      {phone}
      {tweaks}
    </>
  );
}

// Compare screen: shows the same tab, used when side-by-side mode is on.
function CompareScreen({ theme, accent, build, statsView }) {
  // Just reuse Build screen for now
  return <BuildScreen theme={theme} accent={accent} build={build} dispatch={() => {}} />;
}

// ─────────────────────────────────────────────────────────────
// Slot picker — list of items for a single kind
// ─────────────────────────────────────────────────────────────
function SlotPicker({ kind, theme, accent, build, onClose, onPick }) {
  const t = THEMES[theme];
  const list =
    kind === 'weapon' ? LD.weapons :
    kind === 'charm'  ? LD.charm   :
    LD[kind] || [];
  const label = SLOT_KINDS.find(s => s.key === kind)?.label || kind;
  const equippedId = build.slots[kind];
  const [query, setQuery] = React.useState('');
  const filtered = list.filter(i => i.name.toLowerCase().includes(query.toLowerCase()));

  return (
    <div>
      <div style={{
        display: 'flex', alignItems: 'center', justifyContent: 'space-between',
        padding: '8px 16px 4px',
      }}>
        <button onClick={onClose} style={{
          appearance: 'none', border: 0, padding: 0, background: 'transparent',
          color: accent, fontSize: 17, fontWeight: 500, cursor: 'default',
        }}>Cancel</button>
        <div style={{ fontSize: 17, fontWeight: 600, color: t.label }}>Pick {label}</div>
        <button onClick={() => onPick(null)}
          style={{
            appearance: 'none', border: 0, padding: 0, background: 'transparent',
            color: equippedId ? accent : t.label3,
            fontSize: 17, fontWeight: 500, cursor: 'default',
          }} disabled={!equippedId}>Clear</button>
      </div>
      <div style={{ padding: '12px 0 4px' }}>
        <SearchField value={query} onChange={setQuery} theme={theme}
          placeholder={`Search ${label.toLowerCase()}`} />
      </div>
      <Stack theme={theme} gap={20} padding={16}>
        <Card theme={theme} padding={0}>
          {filtered.map((item, i) => (
            <EquipmentRow key={item.id} item={item} theme={theme} accent={accent}
              equipped={equippedId === item.id}
              onClick={() => onPick(item.id)}
              isLast={i === filtered.length - 1} />
          ))}
          {!filtered.length && (
            <div style={{ padding: 20, textAlign: 'center', color: t.label2 }}>No matches.</div>
          )}
        </Card>
      </Stack>
    </div>
  );
}

// ─────────────────────────────────────────────────────────────
// Boot
// ─────────────────────────────────────────────────────────────
const root = ReactDOM.createRoot(document.querySelector('#root .stage'));
root.render(<App />);
